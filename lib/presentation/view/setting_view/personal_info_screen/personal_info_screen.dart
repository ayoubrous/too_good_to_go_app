import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../elements/icon_button.dart';
import '../edit_profile_screen/edit_profile_screen.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => EditProfileScreen());
            },
            child:  Text('edit'.tr),
          ),
        ],
        leading: const CustomBackButton(),
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            children: [
              20.sH,
              Row(
                children: [
                  const CircleAvatar(radius: 35),
                  15.sW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Text('user@gmail.com'),
                    ],
                  ),
                ],
              ),
              15.sH,
              Card(
                color: AppColors.textFieldGreyColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      _buildListTile('fullName'.tr, 'User', Iconsax.user),
                      _buildListTile('email'.tr, 'user@gmail.com', Icons.mail_outline),
                      _buildListTile('phone'.tr, '1234566789', Icons.phone_enabled_outlined),
                    ],
                  ),
                ),
              ),
              15.sH,
              SizedBox(
                height: 58,
                width: double.infinity,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.kPrimaryColor),
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                  ),
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColor,
                                      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                                  child: Column(
                                    children: [
                                      20.sH,
                                      Text(
                                        'areYouSure'.tr,
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                      ),
                                      10.sH,
                                       Text(
                                        'deactivateAccountDialogText'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: AppColors.white),
                                      ),
                                      15.sH,
                                    ],
                                  ),
                                ),
                                10.sH,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child:  Text('cancel'.tr)),
                                    TextButton(onPressed: () {}, child:  Text('oK'.tr)),
                                  ],
                                ),
                                10.sH,
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'deactivateAccount'.tr,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.kPrimaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildListTile(title, subtitle, icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CustomIconButton(
        iconData: icon,
        iconColor: AppColors.kPrimaryColor,
        circleColor: AppColors.white,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
