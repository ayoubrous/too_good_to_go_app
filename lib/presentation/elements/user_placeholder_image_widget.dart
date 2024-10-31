import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant/app_colors.dart';
import '../../utils/constant/image_string.dart';

class UserPlaceHolderWidget extends StatelessWidget {
  final double? width;
   UserPlaceHolderWidget({super.key, this.width, });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: width??Get.width * 0.25,
        width: width??Get.width * 0.25,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          AppImages.userPlaceHolder,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
