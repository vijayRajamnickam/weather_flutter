import 'package:Weather/ui/features/dashboard/data/repository_impl/dashboard_repository_impl.dart';
import 'package:Weather/ui/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:Weather/ui/features/dashboard/domain/usecase/dashboard_usecase.dart';
import 'package:Weather/ui/features/dashboard/domain/usecase_impl/dashboard_usecase_impl.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_network_logger/dio_network_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ui/features/dashboard/data/datasource/dashboard_datasource.dart';
import '../../ui/features/dashboard/data/datasource_impl/dashboard_datasource_impl.dart';
import '../../ui/features/dashboard/presentation/providers/dashboard_provider.dart';
import '../network/logging_interceptor.dart';

var dioProvider = Provider<Dio>((_) {
  var options = BaseOptions(
    baseUrl: '',
    connectTimeout: const Duration(seconds: 40),
    receiveTimeout: const Duration(seconds: 40),
  );

  var dio = Dio(options);
  dio.interceptors.add(LoggerInterceptor());
  dio.interceptors.add(DioNetworkLogger());
  dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
  return dio;
});




var weatherDataSource = Provider.autoDispose<DashboardDataSource>(
    (ref) => DashboardDataSourceImpl(
          ref.watch(dioProvider),
        ));
var weatherRepository = Provider.autoDispose<DashboardRepository>(
    (ref) => DashboardRepositoryImpl(ref.watch(weatherDataSource)));
var weatherUseCase = Provider.autoDispose<DashboardUseCase>(
    (ref) => DashboardUseCaseImpl(ref.watch(weatherRepository)));




var dashboardProvider = ChangeNotifierProvider.autoDispose((ref) =>
    DashboardProvider(ref.watch(weatherUseCase)));
