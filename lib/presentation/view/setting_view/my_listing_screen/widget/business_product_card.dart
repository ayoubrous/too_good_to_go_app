import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../../utils/constant/app_colors.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../../../../utils/custom_shapes/circular_container.dart';

class BusinessProductCard extends StatelessWidget {
  final String pName, businessName, actualPrice, disPrice, pImage;
  final String? rating;
  final VoidCallback? deleteButton, editButton, onTapped, favButton;
  bool isBusinessCard;
  final IconData? favIcon;
  final String? id;

  BusinessProductCard({
    super.key,
    required this.pName,
    this.favIcon,
    required this.businessName,
    required this.actualPrice,
    required this.disPrice,
    required this.pImage,
    this.deleteButton,
    this.editButton,
    this.favButton,
    required this.onTapped,
    this.isBusinessCard = true,
    this.rating,
    this.id,
  });

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: Get.height * 0.24,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.textFieldGreyColor,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Text(
                    pName,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    businessName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: '\$$actualPrice\t'.toString(),
                            style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12)),
                        TextSpan(
                            text: '\$$disPrice',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor)),
                      ],
                    ),
                  ),
                  5.sH,
                  InkWell(
                    onTap: onTapped,
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                      child: Center(
                          child: Text(
                        'view'.tr,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // image
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: Get.height * 0.16,
              width: double.infinity,
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    // pimage
                    Hero(
                      tag: id.toString(),
                      child: SizedBox(
                        height: Get.height * 0.15,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                          imageUrl: pImage.toString(),
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
                    isBusinessCard
                        ? Align(
                            alignment: Alignment.topRight,
                            child: CircularContainer(
                              bg: AppColors.textFieldGreyColor.withOpacity(0.7),
                              margin: EdgeInsets.all(5),
                              height: 40,
                              width: 40,
                              child: Center(
                                child: PopupMenuButton(
                                  iconColor: AppColors.kPrimaryColor,
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      height: 30,
                                      child: Text('Delete'),
                                      onTap: deleteButton,
                                    ),
                                    PopupMenuItem(
                                      height: 30,
                                      child: Text('Edit'),
                                      onTap: editButton,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        :
                        // for simple product..
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularContainer(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Iconsax.star,
                                        color: AppColors.yellowColor,
                                        size: AppSizes.md,
                                      ),
                                      5.sW,
                                      Text(rating.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: CircularContainer(
                                    height: 30,
                                    width: 30,
                                    child: InkWell(
                                      onTap: favButton,
                                      child: Icon(
                                        favIcon,
                                        color: AppColors.yellowColor,
                                        size: AppSizes.md,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
