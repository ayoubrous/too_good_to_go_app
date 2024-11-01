import 'package:flutter/material.dart';

import '../../../../../utils/constant/app_colors.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../../../elements/icon_button.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SettingTile({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.lg),
        ),
        tileColor: AppColors.textFieldGreyColor,
        leading:  CustomIconButton(
          iconData: icon,
          iconColor: AppColors.kPrimaryColor,
          circleColor: AppColors.white,
        ),
        title: Text(title),
      ),
    );
  }
}
