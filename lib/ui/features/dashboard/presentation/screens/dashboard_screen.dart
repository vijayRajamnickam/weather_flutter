import 'package:Weather/core/constants/app_constants.dart';
import 'package:Weather/core/utils/services/permisssion_service.dart';
import 'package:Weather/ui/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:Weather/ui/features/dashboard/presentation/screens/next_week_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/utils/services/prefs.dart';
import '../../data/model/weather_data.dart';

class DashboardWelcomeScreen extends ConsumerStatefulWidget {
  const DashboardWelcomeScreen({super.key});

  @override
  ConsumerState<DashboardWelcomeScreen> createState() =>
      _DashboardWelcomeScreenState();
}

class _DashboardWelcomeScreenState
    extends ConsumerState<DashboardWelcomeScreen> {
  late DashboardProvider _dashboardProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.watch(dashboardProvider).getWeekWeatherData(
      //     Prefs().getDouble(Prefs.latitude)??0.0,Prefs().getDouble(Prefs.longitude)??0.0,);
      // ref.watch(dashboardProvider).getWeatherData(
      //   Prefs().getDouble(Prefs.latitude)??0.0,Prefs().getDouble(Prefs.longitude)??0.0,);
      ref.watch(dashboardProvider).requestLocation();
      ref.watch(dashboardProvider).getCurrentLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dashboardProvider = ref.watch(dashboardProvider);
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Start from top
            end: Alignment.bottomCenter, // End at bottom
            colors: [
              AppColors.primary2,
              AppColors.primary2,
              AppColors.primary,
              AppColors.primary,
            ],
          ),
        ),
        child:
            _dashboardProvider.fetchingData
                ? Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                )
                : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 25, right: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // SizedBox(width: 20),
                                  SvgPicture.asset(
                                    AppImages.outlinedSearch,
                                    width: 24,
                                    height: 24,
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Container(
                                        width: 5,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: AppColors.black,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 5,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: AppColors.black,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 15,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: AppColors.black,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 5,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: AppColors.black,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  SvgPicture.asset(
                                    AppImages.outlinedOptions,
                                    width: 24,
                                    height: 24,
                                  ),
                                  // SizedBox(width: 20),
                                ],
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  _dashboardProvider.weather?.name ?? '',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppColors.appBlack,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  DateFormat(
                                    'EEE, MMM d',
                                  ).format(DateTime.now()),
                                  // "Tue, Jun 30",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30),
                                  Center(
                                    child: SvgPicture.asset(
                                      _dashboardProvider.getImagesAsString(
                                            _dashboardProvider
                                                    .weather
                                                    ?.weather
                                                    ?.first
                                                    .icon ??
                                                "",
                                          ) ??
                                          "",
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(width: 25),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 20),
                                          Text(
                                            _dashboardProvider
                                                    .celsiusTempAsString(
                                                      _dashboardProvider
                                                          .weather
                                                          ?.main
                                                          ?.temp,
                                                    ) ??
                                                '',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: AppColors.appBlack1,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 43,
                                            ),
                                          ),
                                          Text(
                                            _dashboardProvider
                                                    .weather
                                                    ?.weather
                                                    ?.first
                                                    .main
                                                    .toString() ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 15,
                                        right: -10,
                                        child: Text(
                                          "°C",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        weatherInfoCard(
                          icon: AppImages.rainy,
                          label: AppStrings.rainFall,
                          value: "${_dashboardProvider.weather?.rain?.value ?? "0"} cm",
                          shadowColor: AppColors.green,
                        ),
                        weatherInfoCard(
                          icon: AppImages.wind,
                          label: AppStrings.wind,
                          value: "${_dashboardProvider.weather?.wind?.speed?.toStringAsFixed(2) ?? "0"} km/h",
                          shadowColor: AppColors.red,
                        ),
                        weatherInfoCard(
                          icon: AppImages.water,
                          label: AppStrings.humidity,
                          value: "${_dashboardProvider.weather?.main?.humidity ?? "0"}%",
                          shadowColor: AppColors.blue,
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                           decoration: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                  color: AppColors.grey1, // Border color
                                  width: 1.0,         // Border thickness
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _dashboardProvider.isToday = true;
                                    _dashboardProvider.refreshState();
                                  },
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppStrings.today,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color:
                                                _dashboardProvider.isToday
                                                    ? AppColors.appBlack
                                                    : AppColors.grey1,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        if (_dashboardProvider.isToday)
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: AppColors.appBlack,
                                            ),
                                            width: 20,
                                            height: 3,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    _dashboardProvider.isToday = false;
                                    _dashboardProvider.refreshState();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppStrings.tomorrow,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color:
                                                  !_dashboardProvider.isToday
                                                      ? AppColors.appBlack
                                                      : AppColors.grey1,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          if (!_dashboardProvider.isToday)
                                            Container(
                                              width: 35,
                                              height: 3, decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: AppColors.appBlack,
                                            ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WeekScreen(),
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: Row(
                                      children: [
                                        const Text(
                                          AppStrings.next7Days,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: AppColors.grey1,
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          color: AppColors.grey1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        _dashboardProvider.isToday
                            ? Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          _dashboardProvider
                                              .todayWeather
                                              .length,
                                      itemBuilder: (context, index) {
                                        final weather =
                                            _dashboardProvider
                                                .todayWeather[index];
                                        return Container(
                                          width: 65,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                _dashboardProvider.formatTime(
                                                          weather.dt ?? 0,
                                                        ) ==
                                                        "Now"
                                                    ? AppColors.white2
                                                    : AppColors.white3,
                                            // Colors.orange.shade50,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _dashboardProvider.formatTime(
                                                  weather.dt ?? 0,
                                                ),
                                                style: const TextStyle(
                                                  color: AppColors.grey2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              SvgPicture.asset(
                                                _dashboardProvider
                                                        .getImagesAsString(
                                                          weather
                                                              .weather!
                                                              .first
                                                              .icon!,
                                                        ) ??
                                                    "",
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                "${_dashboardProvider.celsiusTempAsString(weather.temp)}°C",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            )
                            : Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          _dashboardProvider
                                              .tomorrowWeather
                                              .length,
                                      itemBuilder: (context, index) {
                                        final weather =
                                            _dashboardProvider
                                                .tomorrowWeather[index];
                                        return Container(
                                          width: 65,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                _dashboardProvider.formatTime(
                                                          weather.dt ?? 0,
                                                        ) ==
                                                        "Now"
                                                    ? AppColors.white2
                                                    : AppColors.white3,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _dashboardProvider.formatTime(
                                                  weather.dt ?? 0,
                                                ),
                                                style: const TextStyle(
                                                  color: AppColors.grey2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              SvgPicture.asset(
                                                _dashboardProvider
                                                        .getImagesAsString(
                                                          weather
                                                              .weather!
                                                              .first
                                                              .icon!,
                                                        ) ??
                                                    "",
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                "${_dashboardProvider.celsiusTempAsString(weather.temp)}°C",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }

  Widget weatherInfoCard({
    required String icon,
    required String label,
    required String value,
    required Color shadowColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor, // No need for null check, required parameter
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SvgPicture.asset(icon, width: 22, height: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),

              /// Value
              Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),

              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }


}
