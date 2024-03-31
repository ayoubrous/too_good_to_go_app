import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

class BusinessRegistrationScreen extends StatelessWidget {
  String groupValue = 'Bakery';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyController());
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text('registrationInfo'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.sH,
                Center(
                  child: CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    pressedOpacity: 0.8,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.textFieldGreyColor),
                      child: Icon(
                        Iconsax.camera,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                10.sH,
                Text(
                  'businessType'.tr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Bakery'),
                    value: 'Bakery',
                    dense: true,
                    groupValue: controller.selectedValue.value,
                    onChanged: (v) => controller.setSelectedValue(v!)),
                RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Cafe'),
                    value: 'Cafe',
                    dense: true,
                    groupValue: controller.selectedValue.value,
                    onChanged: (v) => controller.setSelectedValue(v!)),
                RadioListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text('Restaurant'),
                    value: 'Restaurant',
                    groupValue: controller.selectedValue.value,
                    onChanged: (v) => controller.setSelectedValue(v!)),
                10.sH,
                CustomTextField(hintText: 'businessName'.tr),
                CustomTextField(
                  hintText: 'businessDescription'.tr,
                  maxline: 3,
                ),
                CustomTextField(hintText: 'businessLocation'.tr),
                CustomTextField(
                  hintText: 'phoneNumber'.tr,
                  textInputType: TextInputType.phone,
                ),
                30.sH,
                CustomButton(
                  onTapped: () {},
                  text: 'save'.tr,
                ),
                20.sH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyController extends GetxController {
  var selectedValue = 'Bakery'.obs;

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }
}
