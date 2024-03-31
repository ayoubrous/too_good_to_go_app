import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/utils/custom_shapes/circular_container.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../../utils/constant/app_colors.dart';
import '../../../../../utils/constant/sizes.dart';

class ItemCard extends StatelessWidget {
  final VoidCallback onTapp;
  bool isBusiness;

  ItemCard({super.key, required this.onTapp, this.isBusiness = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            height: Get.height * 0.22,
            // height:Get.height * 0.13,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.textFieldGreyColor,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Product Name', style: Theme.of(context).textTheme.bodyLarge),
                isBusiness
                    ? Row(
                        children: [
                          Text('\$10',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough)),
                          8.sW,
                          Text('\$5',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('3 km',
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.star,
                                color: AppColors.yellowColor,
                                size: AppSizes.md,
                              ),
                              5.sW,
                              Text('5',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                5.sH,
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onTapp,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg))),
                    child: Text(
                      'view'.tr,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 8, left: 8, bottom: 15),
            height: Get.height * 0.14,
            width: double.infinity,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/r.jpg'),
              ),
              borderRadius: BorderRadius.circular(AppSizes.md),
            ),
            child: isBusiness
                ? Align(
                    alignment: Alignment.topRight,
                    child: CircularContainer(
                      height: 30,
                      width: 30,
                      child: PopupMenuButton(
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {},
                            child: const Text(
                              'Delete',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {},
                            child: const Text(
                              'Edit',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {},
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: CircularContainer(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Iconsax.heart5,
                          color: AppColors.yellowColor,
                          size: AppSizes.md,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
