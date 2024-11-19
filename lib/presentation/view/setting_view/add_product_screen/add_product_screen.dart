import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:too_good_to_go_app/controller/product_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_loaders.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';
import 'package:too_good_to_go_app/utils/validators/validators.dart';

import '../../../../utils/constant/app_colors.dart';
import '../../../elements/custom_back_button.dart';
import '../../../elements/pick_image_dialog.dart';

class AddProductScreen extends StatefulWidget {
  var bId;
  var bName;
  var pBusinessImage;
  var pBusinessCayegoryName; // (cafe,hyper mall)
  var pBusinessCayegoryId; // and its id ^

  AddProductScreen({
    super.key,
    required this.bId,
    required this.bName,
    required this.pBusinessImage,
    required this.pBusinessCayegoryName,
    required this.pBusinessCayegoryId,
  });

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String menuName = '';

  String menuId = '';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Obx(
      () => CustomLoader(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            leading: const CustomBackButton(),
            title: Text('addProduct'.tr),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Obx(
                () => Form(
                  key: controller.productKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.sH,
                      Center(
                        child: CupertinoButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isDismissible: false,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadiusLg))),
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
                          child: PhysicalModel(
                            elevation: 9,
                            color: AppColors.textFieldGreyColor,
                            shape: BoxShape.circle,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: AppColors.textFieldGreyColor, boxShadow: []),
                              child: controller.imagePath.value == ''
                                  ? const Icon(
                                      Iconsax.camera,
                                      color: AppColors.kPrimaryColor,
                                    )
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
                          ),
                        ),
                      ),
                      20.sH,
                      CustomTextField(
                        hintText: 'productName'.tr,
                        controller: controller.pName,
                        validator: (v) => BValidators.validateEmptyText('procuct name', v),
                      ),
                      CustomTextField(
                        hintText: 'productDescription'.tr,
                        controller: controller.pDescription,
                        validator: (v) => BValidators.validateEmptyText('product description', v),
                      ),
                      CustomTextField(
                        hintText: 'totalItemLeft'.tr,
                        textInputType: TextInputType.number,
                        controller: controller.pTotalItemLeft,
                        validator: (v) => BValidators.validateEmptyText('total item', v),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: 'actualPrice'.tr,
                              textInputType: TextInputType.number,
                              controller: controller.pActualPrice,
                              // Prevent user input in this field
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "enter actual price";
                                }
                                return null; // Return null if the validation passes
                              },
                            ),
                          ),
                          10.sW,
                          Expanded(
                            child: CustomTextField(
                              hintText: 'disPrice'.tr,
                              textInputType: TextInputType.number,
                              controller: controller.pDisPrice,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "enter dis price";
                                }
                                double actualPrice = double.tryParse(controller.pActualPrice.text) ?? 0;
                                double disPrice = double.tryParse(value) ?? 0;
                                if (disPrice >= actualPrice) {
                                  return 'must less than actual price';
                                }

                                return null; // Return null if the validation passes
                              },
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                selectTime(context, true);
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.textFieldGreyColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(startTime == null
                                    ? 'Start Time' // Prompt to select time if none is selected
                                    : '${startTime!.format(context).toString()}'),
                              ),
                            ),
                          ),
                          10.sW,
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                selectTime(context, false);
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.textFieldGreyColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(endTime == null
                                    ? 'End Time' // Prompt to select time if none is selected
                                    : '${endTime!.format(context).toString()}'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.sH,
                      Obx(
                        () => Wrap(
                          spacing: 8.0, // Space between chips
                          children: List<Widget>.generate(
                            controller.menuList.length,
                            (int index) {
                              final menuItem = controller.menuList[index];

                              return ChoiceChip(
                                label: Text(menuItem['name']),
                                selected: controller.selectedIndex.value == index,
                                onSelected: (bool selected) {
                                  if (selected) {
                                    controller.select(index);

                                    //controller.updateMenuName(menuItem['name']);
                                    print(menuItem['name']);
                                    print(menuItem['menuId']);
                                    menuName = menuItem['name'];
                                    menuId = menuItem['menuId'];
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      25.sH,
                      CustomButton(
                        text: 'upload'.tr,
                        onTapped: () async {
                          if (controller.validateProduct(startTime, endTime)) {
                            controller.isLoading(true);
                            await controller.uploadProductImage();
                            await controller.addProduct(
                              endTime: endTime!.format(context).toString(),
                              startTime: startTime!.format(context).toString(),
                              pBusinessId: widget.bId.toString(),
                              foodTypeName: menuName,
                              foodTypeId: menuId,
                              pBusinessName: widget.bName.toString(),
                              pBusinessImage: widget.pBusinessImage.toString(),
                              businessCatId: widget.pBusinessCayegoryId.toString(),
                              businessCatName: widget.pBusinessCayegoryName.toString(),
                            );
                            controller.isLoading(false);
                          }
                          //if (controller.productKey.currentState!.validate()) {
                          // if (controller.imagePath.value == '')
                          //   BLoaders.warningSnackBar(messagse:'selectAnImage'.tr, title: 'warning'.tr);

                          //}
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
      ),
    );
  }

  TimeOfDay? startTime;

  TimeOfDay? endTime;

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (isStartTime) {
        setState(() {
          startTime = picked;
        });
      } else {
        setState(() {
          endTime = picked;
        });
      }
    }
  }
}
