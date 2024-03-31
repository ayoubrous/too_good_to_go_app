import 'package:flutter/material.dart';

import '../constant/app_colors.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.height ,
    this.width ,
    this.radius = 400,
    this.child,
    this.padding,
    this.bg = AppColors.white,
    this.margin,
    this.borderColor = AppColors.borderPrimary,
    this.clipBehaviour,
  });

  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final double radius;
  final Widget? child;
  final EdgeInsets? margin;
  final Color bg;
  final Color? borderColor;
  final Clip? clipBehaviour;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,

      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? AppColors.borderPrimary,width: 1),
        borderRadius: BorderRadius.circular(radius),
        color: bg,
      ),
      child: child,
    );
  }
}
