import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';

class CustomIconButton extends StatelessWidget {
  final IconData? iconData;
  final Color? iconColor;
  final Color? circleColor;
  final VoidCallback? onTapp;
  final double? height, width;

  const CustomIconButton(
      {super.key, this.iconColor, this.onTapp, this.iconData, this.height, this.width, this.circleColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width ?? 38,
      decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor ?? AppColors.textFieldGreyColor),
      child: GestureDetector(
        onTap: onTapp,
        child: Icon(
          iconData ?? Icons.keyboard_arrow_left_outlined,
          color: iconColor ?? AppColors.blackTextColor,
          size: AppSizes.iconMd,
        ),
      ),
    );
  }
}
