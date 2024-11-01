import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/product_detail_screen/product_detail_screen.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/app_colors.dart';

class BusinessAboutScreen extends StatelessWidget {
  final dynamic data;

  const BusinessAboutScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['bName']),
        leading: const CustomBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.sH,
              //
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      imageUrl: data['bImage'],
                      placeholder: (context, url) => Container(
                        width: 50,
                        height: 50,
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
                  12.sW,
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['bName'],
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text('distance'.tr),
                        const Text('900m'),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.call,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ],
              ),
              15.sH,
              const Divider(),

              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(
                      Iconsax.location,
                      size: AppSizes.iconMd,
                    ),
                    5.sW,
                    Text(
                      'addressOf'.tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(
                      Iconsax.arrow_right_14,
                      color: AppColors.kPrimaryColor,
                    )
                  ],
                ),
              ),
              5.sH,

              Text(data['bLocation']),
              20.sH,
              const Divider(),
              Text(
                'productFromStore'.tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              10.sH,

              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(BackEndConfig.kProduct)
                    .where('pBusinessId', isEqualTo: data['bId'])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    ); // Or any other loading indicator
                  } else if (snapshot.hasError) {
                    return Center(child: Text('error:'.tr + '${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'noProductAvailableForThis'.tr + '${data['bName']}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ); // Or any other appropriate message
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      dynamic productData = snapshot.data!.docs[index];
                      return InkWell(
                        onTap: () => Get.to(
                          () => ProductDetailScreen(
                            data: productData,
                          ),
                        ),
                        child: SizedBox(
                          height: Get.height * 0.155,
                          child: Card(
                            elevation: 5,
                            shadowColor: AppColors.blackTextColor.withOpacity(0.5),
                            color: AppColors.lightRed,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                      imageUrl: productData['pImage'],
                                      placeholder: (context, url) => Container(
                                        width: 50,
                                        height: 50,
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
                                  12.sW,
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productData['pName'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'collectionTime'.tr +
                                              '${productData['pStartTime']} - ${productData['pEndTime']}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Text('\$${productData['pActualPrice']}',
                                                style: const TextStyle(decoration: TextDecoration.lineThrough)),
                                            10.sW,
                                            Text('\$${productData['pDisPrice']}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
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
}
