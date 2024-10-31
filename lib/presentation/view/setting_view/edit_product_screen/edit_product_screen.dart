import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:too_good_to_go_app/controller/edit_product_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_loaders.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/app_colors.dart';
import '../../../elements/custom_back_button.dart';
import '../../../elements/image_builder_widget.dart';
import '../../../elements/pick_image_dialog.dart';

class EditProductScreen extends StatelessWidget {
  final dynamic data;

  const EditProductScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final editProductController = Get.put(EditProductController());

    editProductController.name.text = data['pName'];
    editProductController.description.text = data['pDescription'];
    editProductController.totalItem.text = data['pTotalItemLeft'];
    editProductController.actualPrice.text = data['pActualPrice'];
    editProductController.disPrice.text = data['pDisPrice'];
    editProductController.startTimeController.text = data['pStartTime'];
    editProductController.endTimeController.text = data['pEndTime'];

    return Obx(
      () => CustomLoader(
        isLoading: editProductController.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            leading: const CustomBackButton(),
            title: Text('editProduct'.tr),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.sH,
                    data['pImage'] != null && editProductController.imagePath.value.isEmpty
                        ? Center(
                            child: InkWell(
                              onTap: () {
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
                                        editProductController.pickImage(imageSource: ImageSource.camera);
                                      },
                                      galleryOnPressed: () {
                                        Get.back();
                                        editProductController.pickImage(imageSource: ImageSource.gallery);
                                      },
                                    );
                                  },
                                );
                              },
                              child: ImageBuilderWidget(
                                image: data['pImage'],
                                height: 100,
                                width: 100,
                                imageRadius: 100,
                                progressIndicatorColor: AppColors.kPrimaryColor,
                              ),
                            ),
                          )
                        : Center(
                            child: InkWell(
                              onTap: () {
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
                                        editProductController.pickImage(imageSource: ImageSource.camera);
                                      },
                                      galleryOnPressed: () {
                                        Get.back();
                                        editProductController.pickImage(imageSource: ImageSource.gallery);
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                  height: 100,
                                  width: 100,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.textFieldGreyColor,
                                  ),
                                  child: Image.file(
                                    File(editProductController.imagePath.value),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                    20.sH,
                    CustomTextField(
                      hintText: 'productName'.tr,
                      controller: editProductController.name,
                    ),
                    CustomTextField(
                      hintText: 'productDescription'.tr,
                      controller: editProductController.description,
                    ),
                    CustomTextField(
                      hintText: 'totalItemLeft'.tr,
                      textInputType: TextInputType.number,
                      controller: editProductController.totalItem,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText: 'actualPrice'.tr,
                            textInputType: TextInputType.number,
                            controller: editProductController.actualPrice,
                          ),
                        ),
                        10.sW,
                        Expanded(
                          child: CustomTextField(
                            hintText: 'disPrice'.tr,
                            textInputType: TextInputType.number,
                            controller: editProductController.disPrice,
                          ),
                        ),
                      ],
                    ),
                    8.sH,
                    Text(
                      'collectionTime'.tr,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    10.sH,
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            readOnly: true,
                            controller: editProductController.startTimeController,
                            hintText: 'Start Time',
                            onTapped: () async {
                              editProductController.pickStartTime();
                            },
                          ),
                        ),
                        10.sW,
                        Expanded(
                          child: CustomTextField(
                            readOnly: true,
                            controller: editProductController.endTimeController,
                            hintText: 'End Time',
                            onTapped: () async {
                              editProductController.pickEndTime();
                            },
                          ),
                        ),
                      ],
                    ),
                    25.sH,
                    CustomButton(
                      text: 'update'.tr,
                      onTapped: () async {
                        if (editProductController.imagePath.value.isNotEmpty) {
                          await editProductController.uploadProductImage();
                        } else {
                          editProductController.imageLink.value = data['pImage'];
                        }
                        editProductController.isLoading(true);
                        await editProductController.updateProduct(
                          pEndTime: editProductController.endTimeController.text,
                          pActualPrice: editProductController.actualPrice.text,
                          pDescription: editProductController.description.text,
                          pDisPrice: editProductController.disPrice.text,
                          pImage: editProductController.imageLink.value,
                          pName: editProductController.name.text,
                          pStartTime: editProductController.startTimeController.text,
                          pTotalItem: editProductController.totalItem.text,
                          id: data['pId'],
                        );
                        editProductController.isLoading(false);
                      },
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
