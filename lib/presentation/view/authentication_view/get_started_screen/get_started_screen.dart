import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/select_role_screen/select_role_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.foodPattern), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Center(
                  child: Image.asset(
                    AppImages.getStartedImage,
                    width: AppSizes.imageThumbSize * 3,
                  ),
                ).animate().fade(
                      duration: Duration(milliseconds: 800),
                    ),
             40.sH,
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'welcomeTo'.tr,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  TextSpan(
                    text: 'f'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'ooD'.tr,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  TextSpan(
                    text: 's'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'aver'.tr,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ])).animate().fadeIn(duration: Duration(milliseconds: 900)),
                15.sH,
                Text(
                  'getStartedSubTitle'.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Spacer(flex: 2,),
                CustomButton(
                  text: 'GetStarted'.tr,
                  onTapped: () {
                    Get.offAll(() => SelectRoleScreen());
                  },
                ),
                15.sH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
