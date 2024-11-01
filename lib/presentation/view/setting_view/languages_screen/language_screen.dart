import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/controller/localization_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocalizationController localeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        // leading: CustomBackButton(),
        leading: CustomBackButton(),
        title: Text('languages'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            children: [
              20.sH,
              ListTile(
                onTap: () {
                  localeController.setLocale(const Locale(
                    'en',
                  ));
                },
                contentPadding: EdgeInsets.zero,
                leading: Image.asset(
                  AppImages.english,
                  width: 30,
                ),
                title: Text('english'.tr),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  localeController.setLocale(const Locale('ar'));
                },
                contentPadding: EdgeInsets.zero,
                leading: Image.asset(
                  AppImages.arabic,
                  width: 30,
                ),
                title: Text('arabic'.tr),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  localeController.setLocale(const Locale('fr'));
                },
                contentPadding: EdgeInsets.zero,
                leading: Image.asset(
                  AppImages.french,
                  width: 30,
                ),
                title: Text('french'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
