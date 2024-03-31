import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/icon_button.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/business_about_screen/business_about_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../controller/localization_controller.dart';

class SpecificBusnessScreen extends StatelessWidget {
  final String businessName;

  const SpecificBusnessScreen({super.key, required this.businessName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocalizationController());
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(businessName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            children: [
              20.sH,
              Obx(
                () => InkWell(
                  onTap: () => showDialog(context),
                  child: SizedBox(
                    height: Get.height * 0.16,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                      color: AppColors.textFieldGreyColor,
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.38,
                            height: double.infinity,
                            child: Stack(
                              children: [
                                /// product image
                                Container(
                                  width: Get.width * 0.32,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/r.jpg',
                                      ),
                                    ),
                                  ),
                                ),

                                /// business logo mean shop (cafe,restaurant)
                                Align(
                                  alignment: controller.isArabic.value ? Alignment.centerLeft : Alignment.centerRight,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kPrimaryColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                          10.sW,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SOU QQuan Market',
                                  textDirection: TextDirection.rtl,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text('Distance'),
                                Text('900m'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialog(BuildContext context) {
    Get.bottomSheet(
      isDismissible: false,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadiusLg))),
      Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CustomIconButton(
                iconData: Icons.close,
                onTapp: () {
                  Get.back();
                },
              ),
            ),
            15.sH,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(),
                12.sW,
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SOU QQuan Market',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text('Distance'),
                      Text('900m'),
                    ],
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.to(() => BusinessAboutScreen());
                  },
                  child: Text('about'.tr),
                ),
              ],
            ),
            20.sH,
            Text(
              'productFromStore'.tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            15.sH,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // store logo here
                CircleAvatar(),
                12.sW,
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Name',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text('Tomorrow 05:10 - 10:11'),
                      Text('\$30', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
