import 'package:Weather/ui/features/dashboard/data/model/search_with_lan%20_lon.dart';
import 'package:Weather/ui/features/dashboard/data/model/weather_data_model.dart';
import '../../../../../core/network/error.dart';
import '../../../../../core/utils/either.dart';
import '../../data/model/weather_data.dart';
import '../repository/dashboard_repository.dart';
import '../usecase/dashboard_usecase.dart';

class DashboardUseCaseImpl implements DashboardUseCase {
  DashboardUseCaseImpl(this._repository);

  final DashboardRepository _repository;

  @override
  Future<Either<Failure, WeatherDataModel>> getWeatherData(
    double latitude,
    double longitude,
  ) async {
    return await _repository.getDatingSubscription(latitude, longitude);
  }

  Future<Either<Failure, WeatherModel>> getWeatherModel(
    double latitude,
    double longitude,
  ) async {
    return await _repository.getWeatherModel(latitude, longitude);
  }

  @override
  Future<Either<Failure, List<SearchCityNameWithLatAndLon>>> getCityName(
    String city,
  ) async {
    return await _repository.getCityName(city);
  }
}
