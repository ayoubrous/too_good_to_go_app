import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/controller/login_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_loaders.dart';
import 'package:too_good_to_go_app/presentation/elements/primary_header_appbar.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';
import 'package:too_good_to_go_app/utils/validators/validators.dart';

import '../../../../utils/constant/app_colors.dart';
import '../../../../utils/constant/image_string.dart';
import '../../../elements/custom_button.dart';
import '../../../elements/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();
  final forgotKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Obx(
      () => CustomLoader(
        isLoading: controller.isLoading.value,
        child: Scaffold(
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
                        'forgotPasswordText'.tr,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.white),
                      ),
                      8.sH,
                      Text(
                        'forgotPasswordSubTitle'.tr,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                  child: Form(
                    key: forgotKey,
                    child: Column(
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
                          controller: email,
                          validator: (v) => BValidators.validateEmail(v),
                          hintText: 'email'.tr,
                          isPrefixIcon: true,
                          prefixIcon: CupertinoIcons.mail,
                        ),
                        25.sH,
                        CustomButton(
                          text: 'forgotPasswordText'.tr,
                          onTapped: () {
                            if (forgotKey.currentState!.validate()) {
                              controller.sendEmailResetPassword(email.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
