import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/di/di.dart';
import '../../data/model/search_with_lan _lon.dart';
import '../providers/dashboard_provider.dart';

class AddressSearchScreen extends ConsumerStatefulWidget {
  const AddressSearchScreen({super.key});

  @override
  ConsumerState<AddressSearchScreen> createState() =>
      _AddressSearchScreenState();
}

class _AddressSearchScreenState extends ConsumerState<AddressSearchScreen> {
  FocusNode addressFocusNode = FocusNode();
  late DashboardProvider _dashboardProvider;

  @override
  Widget build(BuildContext context) {
    _dashboardProvider = ref.watch(dashboardProvider);
    return Scaffold(
      backgroundColor: AppColors.primary2,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: AppColors.primary2,
              title: const Text(
                'Search your location',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  placesAutoCompleteTextField(),
                  _dashboardProvider.isLoading
                      ? Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                      : _dashboardProvider.suggestions.isEmpty
                      ? Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Center(
                          child: Text(
                            "City Not Found",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                      )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget placesAutoCompleteTextField() {
    return Material(
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: _dashboardProvider.controller,
        focusNode: addressFocusNode,

        inputDecoration: const InputDecoration(
          hintText: "Enter Address",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          filled: true,
          fillColor: AppColors.white2,
          hintStyle: TextStyle(
            color: AppColors.grey2,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        boxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: AppColors.white),
        ),
        textStyle: TextStyle(
          color: AppColors.grey2,
          fontWeight: FontWeight.bold,
        ),
        debounceTime: 400,
        countries: const ["in"],

        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          Navigator.pop(context);
          _dashboardProvider.controller.clear();
          double latitude = double.tryParse(prediction.lat!) ?? 0.0;
          double longitude = double.tryParse(prediction.lng!) ?? 0.0;
          _dashboardProvider.getWeatherData(latitude, longitude);
          _dashboardProvider.getWeekWeatherData(latitude, longitude);
        },
        itemClick: (Prediction prediction) {
          print(
            "212121 itemClick ${prediction.description} ${prediction.lat} ${prediction.lng}",
          );
        },
        seperatedBuilder: Divider(),
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 2),
                Expanded(child: Text(prediction.description ?? "")),
              ],
            ),
          );
        },
        isCrossBtnShown: true,
        // default 600 ms ,
      ),
    );
  }
}
