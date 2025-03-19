import 'package:Weather/core/constants/app_constants.dart';
import 'package:Weather/ui/features/dashboard/data/model/search_with_lan%20_lon.dart';
import 'package:Weather/ui/features/dashboard/domain/usecase/dashboard_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/constants/show_snackbar.dart';
import '../../data/model/weather_data.dart';
import '../../data/model/weather_data_model.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider(this.dashboardUseCase) {
    print("this one initialised");
  }

  final DashboardUseCase dashboardUseCase;
  bool isToday = true;
  bool fetchingData = true;

  bool isLoading = false;

  int current = 0;
  List<String> features = ["1"];
  WeatherDataModel? weekWeathers;
  WeatherModel? weather;
  List<Hourly>? hourlyData;
  List<Hourly> todayWeather = [];
  List<Hourly> tomorrowWeather = [];
  List<Daily>? dailyData;
  List<Daily>? nextSevenDays;
  List<Daily>? nextSixDays;

  final TextEditingController controller = TextEditingController();
  List<SearchCityNameWithLatAndLon> suggestions = [];

  Future<bool> requestLocation() async {
    print("invoked location access");
    bool isPermissionGranted = false;
    bool locationPermission = await Permission.locationWhenInUse.isGranted;
    print("invoked location access $locationPermission");
    if (!locationPermission) {
      if (!isPermissionGranted) {
        PermissionStatus status = await Permission.locationWhenInUse.request();
        if (status == PermissionStatus.granted ||
            status == PermissionStatus.limited) {
          isPermissionGranted = true;
        }
      }

      if (isPermissionGranted) {
        await getCurrentLocation(); // Ensure location is fetched only once
      }
    } else {
      isPermissionGranted = true;
    }
    return isPermissionGranted;
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      double latitude = position.latitude;
      double longitude = position.longitude;
      // Prefs().setDouble(Prefs.longitude, longitude);
      // Prefs().setDouble(Prefs.latitude, latitude);
      getWeekWeatherData(latitude, longitude);
      getWeatherData(latitude, longitude);
    } catch (e) {
      if (kDebugMode) {
        print("Error getting location: $e");
      }
    }
  }

  Future<void> getWeatherData(double latitude, double longitude) async {
    try {
      var responseData = await dashboardUseCase.getWeatherModel(
        latitude,
        longitude,
      );
      if (responseData.isLeft()) {
        showSnackBar(message: responseData.getLeft().errorMessage);
        return;
      } else {
        weather = responseData.getRight();
        // showSnackBar(message: "WeatherData Fetch SuccessFully");
        notifyListeners();
      }
      notifyListeners();
    } catch (e, stackTrace) {
      print("Error in getWeatherData: $e");
      print("StackTrace: $stackTrace");
      showSnackBar(message: e.toString());
    }
  }

  String? celsiusTempAsString(temp) {
    String? celsiusTemp;
    num? kelvinTemp = temp;
    celsiusTemp =
        kelvinTemp != null ? (kelvinTemp - 273.15).toStringAsFixed(0) : "0";
    return celsiusTemp;
  }

  String? getImagesAsString(String images) {
    String? image;
    if (images == "01d") {
      image = AppImages.sun;
    } else if (images == "01n") {
      image = AppImages.sun;
    } else if (images == "02d") {
      image = AppImages.outlinedCloud;
    } else if (images == "02n") {
      image = AppImages.outlinedCloud;
    } else if (images == "03d") {
      image = AppImages.outlinedCloud;
    } else if (images == "03n") {
      image = AppImages.outlinedCloud;
    } else if (images == "04d") {
      image = AppImages.cloudSun;
    } else if (images == "04n") {
      image = AppImages.cloudSun;
    } else if (images == "09d") {
      image = AppImages.rainyCloud;
    } else if (images == "09n") {
      image = AppImages.rainyCloud;
    } else if (images == "10d") {
      image = AppImages.rainyCloud;
    } else if (images == "10n") {
      image = AppImages.rainyCloud;
    } else if (images == "11d") {
      image = AppImages.rainyCloud;
    } else if (images == "11n") {
      image = AppImages.rainyCloud;
    }

    return image;
  }

  Future<void> getWeekWeatherData(double latitude, double longitude) async {
    fetchingData = true;
    try {
      var responseData = await dashboardUseCase.getWeatherData(
        latitude,
        longitude,
      );
      if (responseData.isLeft()) {
        showSnackBar(message: responseData.getLeft().errorMessage);
        return;
      } else {
        weekWeathers = responseData.getRight();
        hourlyData = responseData.getRight().hourly;
        dailyData = responseData.getRight().daily;
        if (hourlyData!.isNotEmpty) {
          DateTime now = DateTime.now();
          DateTime today = DateTime(now.year, now.month, now.day);
          DateTime tomorrow = today.add(Duration(days: 1));
          todayWeather =
              hourlyData!.where((hour) {
                DateTime time = DateTime.fromMillisecondsSinceEpoch(
                  hour.dt! * 1000,
                );
                return time.year == today.year &&
                    time.month == today.month &&
                    time.day == today.day;
              }).toList();
          tomorrowWeather =
              hourlyData!.where((hour) {
                DateTime time = DateTime.fromMillisecondsSinceEpoch(
                  hour.dt! * 1000,
                );
                return time.year == tomorrow.year &&
                    time.month == tomorrow.month &&
                    time.day == tomorrow.day;
              }).toList();
          if (dailyData!.isNotEmpty) {
            if (dailyData != null && dailyData!.length > 7) {
              nextSevenDays = dailyData?.sublist(1, 8);
              nextSixDays = dailyData?.sublist(2, 8);
            }
          }
          refreshState();
          fetchingData = false;
        }
      }
    } catch (e, stackTrace) {
      print("Error in getWeatherData: $e");
      print("StackTrace: $stackTrace");
      showSnackBar(message: e.toString());
    }
  }

  String formatDay(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('EEEE').format(dateTime); // Example: "Tuesday"
  }

  String formatTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    DateTime now = DateTime.now();
    DateTime lowerBound = dateTime.subtract(Duration(minutes: 30));
    DateTime upperBound = dateTime.add(Duration(minutes: 30));
    if (now.isAfter(lowerBound) && now.isBefore(upperBound)) {
      return "Now";
    }
    return DateFormat('HH:mm').format(dateTime); // Example: "10:00"
  }

  Future<void> getCityName(String city) async {
    isLoading = true;
    try {
      var responseData = await dashboardUseCase.getCityName(city);
      if (responseData.isLeft()) {
        // showSnackBar(message:"Error Fetching City");
        return;
      } else {
        isLoading = false;
        suggestions = responseData.getRight();
        // notifyListeners();
      }
      notifyListeners();
    } catch (e, stackTrace) {
      print("Error in getWeatherData: $e");
      print("StackTrace: $stackTrace");
      // showSnackBar(message: e.toString());
    }
  }

  void refreshState() {
    notifyListeners();
  }
}
