import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/icon_button.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/login_screen/login_screen.dart';
import 'package:too_good_to_go_app/presentation/view/setting_view/business_registration/business_registration.dart';
import 'package:too_good_to_go_app/presentation/view/setting_view/contact_us_screen/contact_us_screen.dart';
import 'package:too_good_to_go_app/presentation/view/setting_view/languages_screen/language_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/decider.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';
import '../favorite_screen/favoite_screen.dart';
import '../my_listing_screen/my_listing_screen.dart';
import '../personal_info_screen/personal_info_screen.dart';
import 'widget/setting_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: SingleChildScrollView(
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
                  Spacer(),
                  CustomIconButton(
                    onTapp: () {
                      Get.to(() => PersonalInfoScreen());
                    },
                    iconData: Iconsax.edit,
                    iconColor: AppColors.kPrimaryColor,
                  ),
                ],
              ),
              8.sH,
              Divider(),
              8.sH,
              Decider.groupValue == 'Business Account'
                  ? Column(
                      children: [
                        SettingTile(
                            title: 'businessRegistration'.tr,
                            onTap: () {
                              Get.to(() => BusinessRegistrationScreen());
                            },
                            icon: Icons.business_center_outlined),
                        SettingTile(
                            title: 'myListing'.tr,
                            onTap: () {
                              Get.to(() => MyListingScreen());
                            },
                            icon: Iconsax.note),
                        SettingTile(title: 'myOrders'.tr, onTap: () {}, icon: CupertinoIcons.car),
                      ],
                    )
                  : SizedBox(),
              SettingTile(
                  title: 'favourite'.tr,
                  onTap: () {
                    Get.to(() => FavoriteScreen());
                  },
                  icon: CupertinoIcons.heart),
              SettingTile(title: 'notification'.tr, onTap: () {}, icon: Iconsax.notification),
              SettingTile(
                  title: 'languages'.tr,
                  onTap: () {
                    Get.to(() => LanguageScreen());
                  },
                  icon: Icons.language),
              SettingTile(
                  title: 'contactus'.tr,
                  onTap: () {
                    Get.to(() => ContactUsScreen());
                    // PersistentNavBarNavigator.pushNewScreen(
                    //   context,
                    //   screen: ContactUsScreen(),
                    //   withNavBar: true,
                    //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    // );
                  },
                  icon: Icons.contact_mail_outlined),
              SettingTile(
                  title: 'Logout'.tr,
                  onTap: () {
                    Get.offAll(() => LoginScreen());
                  },
                  icon: Iconsax.logout),
              SizedBox(height: kToolbarHeight * 1.2),
            ],
          ),
        ),
      ),
    );
  }
}
