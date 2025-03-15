import 'package:Weather/ui/features/dashboard/data/model/search_with_lan%20_lon.dart';
import 'package:Weather/ui/features/dashboard/data/model/weather_data_model.dart';
import '../../../../../core/network/error.dart';
import '../../../../../core/utils/either.dart';
import '../model/weather_data.dart';

abstract class DashboardDataSource {
  Future<Either<Failure, WeatherDataModel>> getDatingSubscription(
    double latitude,
    double longitude,
  );

  Future<Either<Failure, WeatherModel>> getWeatherModel(
    double latitude,
    double longitude,
  );

  Future<Either<Failure,List<SearchCityNameWithLatAndLon>>> getCityName(
    String city,
  );
}
