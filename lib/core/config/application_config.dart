import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';

class ApplicationConfig {
  static final _instance = ApplicationConfig._internal();

  factory ApplicationConfig() {
    return _instance;
  }

  ApplicationConfig._internal();


  void setSystemPreference() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, // dark text for status bar
        statusBarColor: AppColors.primary2,
        systemNavigationBarColor: AppColors.black,
      ),
    );
  }
}
