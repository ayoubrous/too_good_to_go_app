import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTapped;

  const CustomButton({super.key, required this.text, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Get.height*0.078,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
        ),
        onPressed: onTapped,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
