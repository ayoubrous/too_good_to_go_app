import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title:  Text('editProfile'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            children: [
              20.sH,
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.textFieldGreyColor),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    pressedOpacity: 0.8,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.kPrimaryColor),
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              20.sH,
              Divider(),
              15.sH,
              CustomTextField(hintText: 'User'),
              CustomTextField(hintText: '12456788'),
              40.sH,
              CustomButton(
                  text: 'Save',
                  onTapped: () {
                    Get.back();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
