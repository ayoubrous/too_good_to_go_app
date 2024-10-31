import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';

import '../constant/sizes.dart';
import 'custom_theme/text_theme.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.kPrimaryColor,
          selectionColor: AppColors.kPrimaryColor,
          selectionHandleColor: AppColors.lightRed,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.white,
        brightness: Brightness.light,
        primaryColor: AppColors.kPrimaryColor,
        textTheme: AppTextTheme.lightTextTheme(context),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: AppColors.white,
        ),
        dividerTheme: DividerThemeData(thickness: 1, color: AppColors.textFieldGreyColor),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(),
          elevation: 5,
          shadowColor: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: AppColors.kPrimaryColor,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600))),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          checkColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            } else {
              return Colors.black;
            }
          }),
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.kPrimaryColor;
            } else {
              return Colors.transparent;
            }
          }),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          filled: true,
          hoverColor: AppColors.kPrimaryColor,
          errorMaxLines: 2,
          errorStyle: TextStyle(fontSize: 12),
          fillColor: AppColors.textFieldGreyColor,
          hintStyle: const TextStyle(color: AppColors.blackTextColor, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
              borderSide: BorderSide(
                color: AppColors.kPrimaryColor.withOpacity(0.3),
              )),
        ),
        chipTheme: ChipThemeData(
          side: const BorderSide(color: Colors.transparent),
          backgroundColor: AppColors.kPrimaryColor.withOpacity(0.5),
          selectedColor: AppColors.kPrimaryColor,
          checkmarkColor: AppColors.white,
          labelStyle: TextStyle(color: AppColors.white),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.kPrimaryColor,
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: AppColors.textFieldGreyColor,
          entryModeIconColor: AppColors.kPrimaryColor,
          dialHandColor: AppColors.kPrimaryColor,
        ),
    );
  }
}

extension Space on num {
  SizedBox get sH => SizedBox(
        height: toDouble(),
      );

  SizedBox get sW => SizedBox(
        width: toDouble(),
      );
}
