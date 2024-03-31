import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/primary_header_appbar.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/app_colors.dart';
import '../../../../utils/constant/image_string.dart';
import 'package:pinput/pinput.dart';

import '../../../elements/custom_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderAppBar(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.sH,
                  Text(
                    'verification'.tr,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.white),
                  ),
                  8.sH,
                  Text(
                    'verificationSubtitle'.tr,
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
                  const Divider(

                  ),
                  25.sH,
                  Center(
                    child: Pinput(
                      keyboardType: TextInputType.phone,
                      showCursor: true,
                      length: 4,
                      closeKeyboardWhenCompleted: true,
                      defaultPinTheme: PinTheme(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                              border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.3))),
                          textStyle: Theme.of(context).textTheme.titleMedium),
                    ),
                  ),
                  40.sH,
                  CustomButton(
                    text: 'verify'.tr,
                    onTapped: () {
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
