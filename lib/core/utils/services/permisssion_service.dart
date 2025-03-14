import 'package:Weather/core/di/di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config/application_config.dart';

class PermissionService {

  Future<bool> requestLocation() async {
    print("invoked location access");
    bool isPermissionGranted = false;
    bool locationPermission = await Permission.locationWhenInUse.isGranted;
    print("invoked location access $locationPermission");
    if (!locationPermission) {
      PermissionStatus status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        isPermissionGranted = true;
        getCurrentLocation();
      } else if (status == PermissionStatus.limited) {
        isPermissionGranted = true;
        getCurrentLocation();
      }
    } else {
      isPermissionGranted = true;
    }
    return isPermissionGranted;
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, // Use best accuracy
      );
      double latitude = position.latitude;
      double longitude = position.longitude;
      print("Latitude: $latitude, Longitude: $longitude");
    } catch (e) {
      print("Error getting location: $e");
    }
  }

// permission = await Geolocator.checkPermission();
// if (permission == LocationPermission.denied) {
// permission = await Geolocator.requestPermission();
// if (permission == LocationPermission.denied) {
// print("Location permission denied.");
// return;
// }

}
