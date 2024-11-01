import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/controller/business_registration_controller.dart';
import 'package:too_good_to_go_app/presentation/view/setting_view/add_product_screen/add_product_screen.dart';
import 'package:too_good_to_go_app/presentation/view/setting_view/edit_product_screen/edit_product_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/image_string.dart';
import '../../../elements/custom_back_button.dart';
import '../../home_view/product_detail_screen/product_detail_screen.dart';
import 'widget/business_product_card.dart';

class MyListingScreen extends StatelessWidget {
  const MyListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final businessController = Get.put(BusinessRegistrationController());
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: businessController.isApproved.value
              ? Text(businessController.businessName.value)
              : Text('businessName'.tr),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.sH,
                  // not created yet!
                  if (!businessController.isCreated.value)
                    Column(
                      children: [
                        const SizedBox(height: kToolbarHeight * 1.5),
                        Text(
                          'firstCreateBusinessThenYouwillabletoAddProduct'.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: kToolbarHeight),
                        Image.asset(
                          AppImages.createBusiness,
                          width: Get.width * 0.6,
                        ),
                      ],
                    ),
                  // created but not approved yet!
                  if (businessController.isCreated.value && !businessController.isApproved.value)
                    Column(
                      children: [
                        const SizedBox(height: kToolbarHeight * 1.5),
                        Text(
                          'businessIsCreatedWaitForApprovalFromAdmin'.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: kToolbarHeight),
                        Image.asset(
                          AppImages.waitingApproval,
                          width: Get.width * 0.6,
                        ),
                      ],
                    ),

                  if (businessController.isCreated.value &&
                      businessController.isApproved.value &&
                      !businessController.isBlocked.value)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Detail',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        10.sH,
                        businessController.isApproved.value
                            ? Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.textFieldGreyColor,
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 40,
                                      height: 40,
                                      imageUrl: businessController.businessImage.value.toString(),
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
                                  15.sW,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(businessController.businessName.value.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text(businessController.bCategory.value.toString()),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        10.sH,
                        Divider(),
                        10.sH,
                        Text(
                          'myProducts'.tr,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        20.sH,
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(BackEndConfig.kProduct)
                              .where(
                                'pBusinessId',
                                isEqualTo: businessController.businessId.value,
                              )
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Column(
                                  children: [
                                    const SizedBox(height: kToolbarHeight / 2),
                                    Text(
                                      'noProductHaveBeenAddedYet'.tr,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: kToolbarHeight),
                                    Image.asset(
                                      AppImages.notProductYet,
                                      width: Get.width * 0.6,
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              Text(
                                'someThingWentWrong'.tr,
                                style: Theme.of(context).textTheme.bodyLarge,
                              );
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.kPrimaryColor,
                                  strokeWidth: 5,
                                ),
                              );
                            }
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.7,
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                              ),
                              itemBuilder: (context, index) {
                                var data = snapshot.data!.docs[index];
                                return BusinessProductCard(
                                  pImage: data['pImage'].toString(),
                                  pName: data['pName'],
                                  businessName: data['pBusinessName'],
                                  actualPrice: data['pActualPrice'],
                                  disPrice: data['pDisPrice'],
                                  editButton: () {
                                    Get.to(() => EditProductScreen(data: data));
                                  },
                                  deleteButton: () {
                                    FirebaseFirestore.instance.collection(BackEndConfig.kProduct).doc(data.id).delete();
                                  },
                                  onTapped: () {
                                    Get.to(
                                      () => ProductDetailScreen(
                                        data: data,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  if (businessController.isBlocked.value && businessController.isApproved.value)
                    Column(
                      children: [
                        const SizedBox(height: kToolbarHeight * 1.5),
                        Text(
                          'Your Business is Blocked due to some reason'.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: kToolbarHeight),
                        const Icon(
                          Icons.block,
                          color: AppColors.kPrimaryColor,
                          size: AppSizes.iconLg,
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: businessController.isApproved.value &&
                businessController.isCreated.value &&
                !businessController.isBlocked.value
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(
                    () => AddProductScreen(
                      pBusinessImage: businessController.businessImage.value,
                      bId: businessController.businessId.value,
                      bName: businessController.businessName.value,
                      pBusinessCayegoryName: businessController.bCategory.value,
                      pBusinessCayegoryId: businessController.bCategoryId.value,
                    ),
                  );
                  print(businessController.businessId.value);
                },
                child: Text('add'.tr),
              )
            : const SizedBox(),
      ),
    );
  }
}
