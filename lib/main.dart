import 'package:Weather/core/constants/app_colors.dart';
import 'package:Weather/ui/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      navigatorKey: navigatorKey,
      theme: ThemeData(colorSchemeSeed: AppColors.primary),
      home: DashboardWelcomeScreen(),
    );
  }
}
