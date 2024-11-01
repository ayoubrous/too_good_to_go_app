import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:too_good_to_go_app/controller/profile_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_loaders.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../elements/pick_image_dialog.dart';

class EditProfileScreen extends StatelessWidget {
  final String name;
  final String phoneNumber;
  var image;

  EditProfileScreen({super.key, required this.name, required this.phoneNumber, required this.image});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    controller.nameController.text = name;
    controller.phoneController.text = phoneNumber;
    return Obx(
      () => CustomLoader(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            leading: const CustomBackButton(),
            title: Text('editProfile'.tr),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Obx(
                () => Column(
                  children: [
                    20.sH,

                    /// profile image
                    /// /// if the both are empty then show placeholder

                    Container(
                      height: 105,
                      width: 105,
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.textFieldGreyColor,
                            ),
                            child: image == '' && controller.imagePath.value.isEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      AppImages.userPlaceHolder,
                                      width: 60,
                                    ),
                                  )
                                : image != '' && controller.imagePath.value.isEmpty
                                    ? PhysicalModel(
                                        elevation: 8,
                                        borderRadius: BorderRadius.circular(100),
                                        color: AppColors.textFieldGreyColor,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            width: 80,
                                            height: 80,
                                            imageUrl: image.toString(),
                                            placeholder: (context, url) => Container(
                                              width: 60,
                                              height: 60,
                                              color: AppColors.textFieldGreyColor, // Placeholder background color
                                              child: const Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColors.kPrimaryColor, // Loader color
                                                ),
                                              ),
                                            ),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                        ),
                                      )
                                    // ImageBuilderWidget(
                                    //             image: image,
                                    //             imageRadius: 100,
                                    //           )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.file(
                                          File(
                                            controller.imagePath.value,
                                          ),
                                          width: 80,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CupertinoButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isDismissible: false,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadiusLg))),
                                  context: context,
                                  builder: (context) {
                                    return PickImageDialog(
                                      cameraOnPressed: () {
                                        Get.back();
                                        controller.pickImage(imageSource: ImageSource.camera);
                                      },
                                      galleryOnPressed: () {
                                        Get.back();
                                        controller.pickImage(imageSource: ImageSource.gallery);
                                      },
                                    );
                                  },
                                );
                              },
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
                        ],
                      ),
                    ),
                    20.sH,
                    const Divider(),
                    15.sH,
                    CustomTextField(
                      hintText: '',
                      controller: controller.nameController,
                    ),
                    CustomTextField(
                      hintText: '12456788',
                      controller: controller.phoneController,
                    ),
                    40.sH,
                    CustomButton(
                        text: 'save'.tr,
                        onTapped: () async {
                          controller.isLoading(true);
                          if (controller.imagePath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.imageLink.value = image.toString();
                          }

                          controller.updateProfile(
                              phoneNumber: controller.phoneController.text,
                              name: controller.nameController.text,
                              imgUrl: controller.imageLink.value);
                          controller.isLoading(false);
                        }),
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
