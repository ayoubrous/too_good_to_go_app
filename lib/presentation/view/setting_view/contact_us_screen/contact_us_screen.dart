import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/icon_button.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../elements/custom_back_button.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text('contactus'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            children: [
              20.sH,
              Image.asset(
                AppImages.contactUs,
                width: Get.width * 0.6,
                alignment: Alignment.center,
              ),
              25.sH,
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {},
                leading: const CustomIconButton(
                  circleColor: AppColors.textFieldGreyColor,
                  iconData: Icons.mail_outline,
                  iconColor: AppColors.kPrimaryColor,
                ),
                title: const Text(
                  'user@gmail.com',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
