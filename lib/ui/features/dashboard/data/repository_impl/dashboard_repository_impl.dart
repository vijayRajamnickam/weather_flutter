import 'package:Weather/ui/features/dashboard/data/model/weather_data_model.dart';

import '../../../../../core/network/error.dart';
import '../../../../../core/utils/either.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../datasource/dashboard_datasource.dart';
import '../model/weather_data.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl(this._datasource);

  final DashboardDataSource _datasource;

  @override
  Future<Either<Failure, WeatherDataModel>> getDatingSubscription(
    double latitude,
    double longitude,
  ) async {
    return await _datasource.getDatingSubscription(latitude, longitude);
  }

  @override
  Future<Either<Failure, WeatherModel>> getWeatherModel(
    double latitude,
    double longitude,
  ) async {
    return await _datasource.getWeatherModel(latitude, longitude);
  }
}
