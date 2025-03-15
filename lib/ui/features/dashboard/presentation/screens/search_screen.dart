import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
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
              title: const Text('Search your location'),
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
                        child: Center(child: Text("City Not Found")),
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
      borderRadius: BorderRadius.circular(6.0),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }

          return _dashboardProvider.suggestions
              .map((city) => city.displayName ?? "")
              .where((name) => name.isNotEmpty);
        },
        onSelected: (String selection) {
          Navigator.pop(context);
          var selectedCity = _dashboardProvider.suggestions!.firstWhere(
            (city) => city.displayName == selection,
            orElse: () => SearchCityNameWithLatAndLon(),
          );
          if (selectedCity.lat != null && selectedCity.lon != null) {
            double latitude = double.tryParse(selectedCity.lat!) ?? 0.0;
            double longitude = double.tryParse(selectedCity.lon!) ?? 0.0;
            _dashboardProvider.getWeatherData(latitude, longitude);
            _dashboardProvider.getWeekWeatherData(latitude, longitude);
          }
        },
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: "Enter City Name",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _dashboardProvider.getCityName(value);
            },
          );
        },
      ),
    );
  }
}
