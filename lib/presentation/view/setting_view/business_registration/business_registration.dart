import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_loaders.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../controller/business_registration_controller.dart';
import '../../../../utils/custom_shapes/circular_container.dart';

class BusinessRegistrationScreen extends StatelessWidget {
  // String groupValue = 'Bakery';

  @override
  Widget build(BuildContext context) {
    final businessController = Get.put(BusinessRegistrationController());
    return Obx(
      () => CustomLoader(
        isLoading: businessController.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            leading: const CustomBackButton(),
            title: Text('registrationInfo'.tr),
          ),
          body: businessController.isCreated.value
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'OnlyOneBusinessIsCreatedForOneOwner'.tr,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        20.sH,
                        const Icon(
                          Iconsax.shop5,
                          size: AppSizes.iconLg,
                          color: AppColors.kPrimaryColor,
                        )
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.sH,
                          Center(
                            child: CupertinoButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isDismissible: false,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadiusLg))),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.lg, vertical: AppSizes.lg / 2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'pickImage'.tr,
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                              const CloseButton(),
                                            ],
                                          ),
                                          15.sH,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CircularContainer(
                                                padding: const EdgeInsets.all(12),
                                                child: IconButton(
                                                  onPressed: () {
                                                    Get.back();

                                                    businessController.pickImage(imageSource: ImageSource.camera);
                                                  },
                                                  icon: const Icon(
                                                    Iconsax.camera,
                                                    color: AppColors.kPrimaryColor,
                                                  ),
                                                ),
                                              ),
                                              CircularContainer(
                                                padding: const EdgeInsets.all(12),
                                                child: IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                    businessController.pickImage(imageSource: ImageSource.gallery);
                                                  },
                                                  icon: const Icon(
                                                    Iconsax.gallery,
                                                    color: AppColors.kPrimaryColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          15.sH,
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              padding: EdgeInsets.zero,
                              pressedOpacity: 0.8,
                              child: PhysicalModel(
                                elevation: 9,
                                color: AppColors.textFieldGreyColor,
                                shape: BoxShape.circle,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.textFieldGreyColor,
                                  ),
                                  child: businessController.imagePath.value == ''
                                      ? const Icon(
                                          Iconsax.camera,
                                          color: AppColors.kPrimaryColor,
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.file(
                                            File(
                                              businessController.imagePath.value,
                                            ),
                                            width: 80,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          10.sH,
                          Text(
                            'businessType'.tr,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          15.sH,
                          InkWell(
                            onTap: () {
                              businessController.isTapped.value = !businessController.isTapped.value;
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: AppSizes.borderRadiusLg),
                              height: 53,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.textFieldGreyColor,
                                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    businessController.catName != "" ? businessController.catName : "Category Name",
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w400),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      //businessController.isTapped.value = !businessController.isTapped.value;
                                    },
                                    icon: Icon(
                                      businessController.isTapped.value
                                          ? Icons.keyboard_arrow_up_outlined
                                          : Icons.keyboard_arrow_down_sharp,
                                      color: AppColors.kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (businessController.isTapped.value)
                            Obx(
                              () => Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 2,
                                  color: AppColors.textFieldGreyColor,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: businessController.allCategories.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                            onTap: () {
                                              businessController.catName = businessController.allCategories[i]["name"];
                                              businessController.catID =
                                                  businessController.allCategories[i]["businessCatId"];
                                              businessController.isTapped.value = !businessController.isTapped.value;
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                              child: Text(
                                                businessController.allCategories[i]["name"],
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            ));
                                      }),
                                ),
                              ),
                            ),
                          // RadioListTile(
                          //     contentPadding: EdgeInsets.zero,
                          //     title: const Text('Bakery'),
                          //     value: 'Bakery',
                          //     dense: true,
                          //     groupValue: controller.selectedValue.value,
                          //     onChanged: (v) => controller.setSelectedValue(v!)),

                          10.sH,
                          CustomTextField(
                            controller: businessController.bName,
                            hintText: 'businessName'.tr,
                          ),
                          CustomTextField(
                            controller: businessController.bDescription,
                            hintText: 'businessDescription'.tr,
                            maxline: 3,
                          ),
                          CustomTextField(
                            controller: businessController.bLocation,
                            hintText: 'businessLocation'.tr,
                          ),
                          CustomTextField(
                            controller: businessController.bPhoneNumber,
                            hintText: 'phoneNumber'.tr,
                            textInputType: TextInputType.phone,
                          ),
                          30.sH,

                          CustomButton(
                            onTapped: () async {
                              if (businessController.validateBusiness()) {
                                businessController.isLoading(true);
                                await businessController.uploadBusinessImage();
                                businessController.addBusiness(isCreated: true);
                                businessController.isLoading(false);
                              }
                            },
                            text: 'save'.tr,
                          ),
                          20.sH,
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
