import 'package:flutter/material.dart';

import '../../main.dart';
import '../constants/app_colors.dart';

void showSnackBar({
  BuildContext? context,
  required String message,
  int seconds = 2,
  Color? bgColor,
}) {
  ScaffoldMessenger.of(navigatorKey.currentState!.context)
      .hideCurrentSnackBar();
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.horizontal,
    backgroundColor: bgColor ?? AppColors.white,
    duration: Duration(seconds: seconds),
    content: GestureDetector(
      onTap: () {
        hideSnackBar();
      },
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
    ),
  );
  ScaffoldMessenger.of(navigatorKey.currentState!.context)
      .showSnackBar(snackBar)
      .closed
      .then((value) => ScaffoldMessenger.of(navigatorKey.currentState!.context)
          .clearSnackBars());
}

void hideSnackBar() {
  ScaffoldMessenger.of(navigatorKey.currentState!.context)
      .hideCurrentSnackBar();
}
