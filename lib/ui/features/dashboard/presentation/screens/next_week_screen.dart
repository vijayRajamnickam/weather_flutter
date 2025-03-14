import 'package:Weather/core/constants/app_constants.dart';
import 'package:Weather/ui/features/dashboard/data/model/weather_data_model.dart';
import 'package:Weather/ui/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/di/di.dart';

class WeekScreen extends ConsumerStatefulWidget {
  const WeekScreen({super.key});

  @override
  ConsumerState<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends ConsumerState<WeekScreen> {
  late DashboardProvider _dashboardProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
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
        child: SafeArea(
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
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back, size: 24),
                        ),
                        Spacer(),
                        Text(
                          AppStrings.next7Days,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppColors.appBlack,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                        SizedBox(width: 24),
                      ],
                    ),
                    SizedBox(height: 40),
                    Material(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.white1,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    AppStrings.tomorrow,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: AppColors.appBlack,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    " ${_dashboardProvider.celsiusTempAsString(_dashboardProvider.nextSevenDays?.first.temp?.max)}°",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: AppColors.appBlack1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Center(
                                    child: SvgPicture.asset(
                                      _dashboardProvider.getImagesAsString(
                                            _dashboardProvider
                                                    .nextSevenDays
                                                    ?.first
                                                    .weather
                                                    ?.first
                                                    .icon ??
                                                "",
                                          ) ??
                                          "",
                                      width: 75,
                                      height: 75,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.green,
                                                spreadRadius: 0,
                                                // No spread
                                                blurRadius: 5,
                                                // Adjust for a softer effect
                                                offset: Offset(
                                                  0,
                                                  3,
                                                ), // Moves shadow only downward
                                              ),
                                            ],
                                          ),
                                          child: SvgPicture.asset(
                                            AppImages.rainy,
                                            width: 22,
                                            height: 22,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${_dashboardProvider.nextSevenDays?.first.rain ?? "0"} cm",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: AppColors.appBlack,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.red,
                                                spreadRadius: 0,
                                                // No spread
                                                blurRadius: 5,
                                                // Adjust for a softer effect
                                                offset: Offset(
                                                  0,
                                                  3,
                                                ), // Moves shadow only downward
                                              ),
                                            ],
                                          ),
                                          child: SvgPicture.asset(
                                            AppImages.wind,
                                            width: 22,
                                            height: 22,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${_dashboardProvider.nextSevenDays?.first.windSpeed?.toStringAsFixed(2) ?? ""} km/h",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: AppColors.appBlack,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.blue,
                                                spreadRadius: 0,
                                                // No spread
                                                blurRadius: 5,
                                                // Adjust for a softer effect
                                                offset: Offset(
                                                  0,
                                                  3,
                                                ), // Moves shadow only downward
                                              ),
                                            ],
                                          ),
                                          child: SvgPicture.asset(
                                            AppImages.water,
                                            width: 22,
                                            height: 22,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${_dashboardProvider.nextSevenDays?.first.humidity ?? ""}%",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: AppColors.appBlack,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                child: ListView.builder(
                  itemCount: _dashboardProvider.nextSixDays!.length,
                  itemBuilder: (context, index) {
                    final weather = _dashboardProvider.nextSixDays![index];
                    return dayWidget(weather);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dayWidget(Daily data) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white1,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              SizedBox(width: 10),
              Text(
                _dashboardProvider.formatDay(data.dt ?? 0),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.appBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              Text(
                " ${_dashboardProvider.celsiusTempAsString(data.temp?.max)}°",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.appBlack1,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 50,
                height: 50,
                child: SvgPicture.asset(
                  _dashboardProvider.getImagesAsString(
                        data.weather?.first.icon ?? "",
                      ) ??
                      "",
                  width: 50,
                  height: 50,
                  // fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
