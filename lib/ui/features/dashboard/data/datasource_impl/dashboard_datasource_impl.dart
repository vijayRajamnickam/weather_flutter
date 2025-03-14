import 'package:Weather/core/network/extension.dart';
import 'package:Weather/ui/features/dashboard/data/model/weather_data_model.dart';
import 'package:dio/dio.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/network/error.dart';
import '../../../../../core/utils/either.dart';
import '../datasource/dashboard_datasource.dart';
import '../model/weather_data.dart';

class DashboardDataSourceImpl implements DashboardDataSource {
  final Dio dio;

  DashboardDataSourceImpl(this.dio);


  @override
  Future<Either<Failure, WeatherDataModel>> getDatingSubscription(
    double latitude,
    double longitude,
  ) async {
    var result = Either<Failure, WeatherDataModel>();
    try {
      String appId = "514ab3ff7d14e85851ab74e7ddabf161";
      var rawResponse = await dio.get("https://api.openweathermap.org/data/3.0/onecall", queryParameters: {
        "lat":latitude,
        "lon":longitude,
        "appid":appId,
      });
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        result.setRight(weatherDataModelFromJson(response.getRight()));
      }
    } on Exception catch (e) {
      if (e is DioException) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(e.toString().getFailureType());
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, WeatherModel>> getWeatherModel(
    double latitude,
    double longitude,
  ) async {
    var result = Either<Failure, WeatherModel>();
    try {
      String appId = "514ab3ff7d14e85851ab74e7ddabf161";
      var rawResponse = await dio.get("https://api.openweathermap.org/data/2.5/weather", queryParameters: {
        "lat":latitude,
        "lon":longitude,
        "appid":appId,
      });
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        result.setRight(weatherModelFromJson(response.getRight()));
      }
    } on Exception catch (e) {
      if (e is DioException) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(e.toString().getFailureType());
      }
    }
    return result;
  }
}
