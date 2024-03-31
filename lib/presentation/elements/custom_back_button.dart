import 'package:flutter/material.dart';

import '../../utils/constant/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.textFieldGreyColor,
        child: BackButton(
          style: ButtonStyle(
            iconSize: MaterialStatePropertyAll<double>(20),
          ),
        ),
      ),
    );
  }
}
