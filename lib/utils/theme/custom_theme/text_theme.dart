import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';

class AppTextTheme {
  static lightTextTheme(BuildContext context) {
    return GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme.apply().copyWith(
            headlineLarge: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w600,
              color: AppColors.blackTextColor,
            ),
            headlineMedium: const TextStyle().copyWith(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: AppColors.blackTextColor,
            ),
            headlineSmall: const TextStyle().copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            titleLarge: const TextStyle().copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.blackTextColor,
            ),
            titleMedium: const TextStyle().copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.blackTextColor,
            ),
            titleSmall: const TextStyle().copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.blackTextColor,
            ),
            bodyLarge: const TextStyle().copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.blackTextColor,
            ),
            bodyMedium: const TextStyle().copyWith(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppColors.blackTextColor,
            ),
            bodySmall: const TextStyle().copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.5),
            ),
            labelLarge: const TextStyle().copyWith(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: AppColors.blackTextColor,
            ),
            labelMedium: const TextStyle().copyWith(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
    );
  }
}
