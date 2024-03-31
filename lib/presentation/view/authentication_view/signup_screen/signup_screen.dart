import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/navigation_bar_view/navigation_bar_screen.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/app_colors.dart';
import '../../../../utils/constant/image_string.dart';
import '../../../../utils/constant/sizes.dart';
import '../../../elements/custom_button.dart';
import '../../../elements/custom_text_field.dart';
import '../../../elements/primary_header_appbar.dart';
import '../access_location_screen/access_location_screen.dart';
import '../login_screen/widget/social_icons.dart';
import '../phone_login_screen/phone_login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderAppBar(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  20.sH,
                  Text(
                    'createAccount'.tr,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.white),
                  ),
                  8.sH,
                  Text(
                    'signUpsubTitle'.tr,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      AppImages.appLogo,
                      width: 80,
                    ),
                  ),
                  15.sH,
                  const Divider(),
                  15.sH,
                  CustomTextField(
                    hintText: 'name'.tr,
                    isPrefixIcon: true,
                    prefixIcon: CupertinoIcons.person,
                  ),
                  CustomTextField(
                    hintText: 'email'.tr,
                    isPrefixIcon: true,
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: CupertinoIcons.mail,
                  ),
                  CustomTextField(
                    hintText: 'phoneNumber'.tr,
                    isPrefixIcon: true,
                    textInputType: TextInputType.phone,
                    prefixIcon: Iconsax.mobile,
                  ),
                  CustomTextField(
                    hintText: 'password'.tr,
                    isPrefixIcon: true,
                    prefixIcon: Iconsax.password_check,
                    isPasswordField: true,
                    obsecureText: true,
                  ),
                  CustomTextField(
                    hintText: 'confirmPassword'.tr,
                    isPrefixIcon: true,
                    prefixIcon: Iconsax.password_check,
                    isPasswordField: true,
                    obsecureText: true,
                  ),
                  25.sH,
                  CustomButton(
                      text: 'signup'.tr,
                      onTapped: () {
                        Get.offAll(() => AccessLocationScreen());
                      }),
                  15.sH,
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'alreadyHaveAnAccount?'.tr, style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(
                              text: 'login'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.back();
                                }),
                        ],
                      ),
                    ),
                  ),
                  20.sH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIocns(
                        ontapped: () {},
                        widget: Image.asset(AppImages.google),
                      ),
                      SocialIocns(
                        ontapped: () {},
                        widget: Image.asset(AppImages.facebook),
                      ),
                      SocialIocns(
                        ontapped: () {
                          Get.to(() => PhoneLoginScreen());
                        },
                        widget: const Icon(
                          Icons.phone,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kToolbarHeight / 1.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
