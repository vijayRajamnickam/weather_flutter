import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../network/network_controller.dart';
import '../utils/services/prefs.dart';

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


  Future<void> setApplicationPreferences() async {
    await Prefs().instance();
    HttpOverrides.global = _MyHttpOverrides();
    NetworkController().initialiseNetworkMonitor();
    AppLinks().uriLinkStream.listen((uri) {});
  }
}

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
