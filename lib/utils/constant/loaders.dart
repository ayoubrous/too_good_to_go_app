import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import 'app_colors.dart';

class BLoaders {
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message, required color}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: color,
            ),
            child: Center(
                child: Text(message,
                    style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: AppColors.white)))),
      ),
    );
  }

  static successSnackBar({required title, messagse = '', duration = 2}) {
    Get.snackbar(
      title,
      messagse,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: AppColors.kGreenColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(8),
      icon: Icon(Icons.done_all, color: AppColors.white),
    );
  }

  static warningSnackBar({title = '', messagse = ''}) {
    Get.snackbar(
      title,
      messagse,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(8),
      icon: Icon(Iconsax.warning_2, color: AppColors.white),
    );
  }

  static errorSnackBar({required title, messagse = ''}) {
    Get.snackbar(
      title,
      messagse,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(8),
      icon: Icon(Iconsax.warning_2, color: AppColors.white),
    );
  }
}
