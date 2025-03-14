import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import 'app_colors.dart';

class ProgressLoader {
  void showDialog(BuildContext? context,
      {double portraitWidth = 85,
        double landscapeWidth = 50,
        double portraitHeight = 63,
        double landscapeHeight = 32,
        Color? color,
        AlignmentGeometry position = Alignment.center}) {
    if (context == null) {
      return;
    }
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: color ?? AppColors.black.withOpacity(0.2),
      // space around dialog
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Consumer(builder: (context, ref, _) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.black.withOpacity(0.2),
            child: Stack(
              children: [
                SlideTransition(
                  position:
                  Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                      .animate(animation),
                  child: const Stack(
                    children: [
                      Center(
                          child: CircularProgressIndicator(
                            color:  AppColors.white,
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  void show(BuildContext? context, Color? color) {
    showDialog(context, color: color);
  }
}

void showLoader([Color? color]) {
  ProgressLoader().show(navigatorKey.currentContext, color);
}

void hideLoader([Color? color]) {
  Navigator.pop(navigatorKey.currentContext!);
}
