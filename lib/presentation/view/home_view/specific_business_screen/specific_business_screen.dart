import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/icon_button.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/business_about_screen/business_about_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../controller/localization_controller.dart';

class SpecificBusnessScreen extends StatelessWidget {
  final String Catid;
  final String CatName;

  const SpecificBusnessScreen({super.key, required this.Catid, required this.CatName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocalizationController());
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(CatName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.sH,
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(BackEndConfig.kBusiness)
                    .where('bCategoryId', isEqualTo: Catid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    ); // Or any other loading indicator
                  } else if (snapshot.hasError) {
                    return Center(child: Text('error'.tr + '${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'NoBusinessCreatedFor'.tr + '\n$CatName',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ); // Or any other appropriate message
                  }
                  // businessController.isApproved.value &&
                  //     !businessController.isBlocked.value

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      dynamic data = snapshot.data!.docs[index];
                      //if (data['isApproved'] == true && data['isBlocked'] == false) {
                      return InkWell(
                        onTap: data['isApproved'] == true && data['isBlocked'] == false
                            ? () => Get.to(
                                  () => BusinessAboutScreen(
                                    data: data,
                                  ),
                                )
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: SizedBox(
                            height: Get.height * 0.16,
                            width: double.infinity,
                            child: Card(
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                              color: AppColors.lightRed,
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.3,
                                    height: Get.height * 0.16,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: data['bImage'],
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
                                  ),
                                  10.sW,
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // 5.sH,
                                        Spacer(),
                                        Text(
                                          data['bName'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textDirection: TextDirection.rtl,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        Divider(),
                                        Spacer(),
                                        Text(
                                          'address'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontWeight: FontWeight.w500),
                                        ),

                                        Text(
                                          data['bLocation'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  5.sW,
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                      // }
                    },
                  );
                },
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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadiusLg))),
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
                const CircleAvatar(),
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
                      const Text('Distance'),
                      const Text('900m'),
                    ],
                  ),
                ),
                const Spacer(),
                // TextButton(
                //   onPressed: () {
                //     Get.back();
                //     Get.to(() =>  BusinessAboutScreen());
                //   },
                //   child: Text('about'.tr),
                // ),
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
                const CircleAvatar(),
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
                      const Text('Tomorrow 05:10 - 10:11'),
                      const Text('\$30', style: TextStyle(fontWeight: FontWeight.bold)),
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
