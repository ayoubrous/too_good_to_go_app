import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/product_detail_screen/product_detail_screen.dart';
import 'package:too_good_to_go_app/utils/custom_shapes/circular_container.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../../utils/constant/app_colors.dart';
import '../../../../../utils/constant/sizes.dart';

class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ProductDetailScreen(),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Stack(
        children: [
          // content container...
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: Get.height * 0.22,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.textFieldGreyColor,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Product Name',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Restaurant Name',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: '\$10\t\t', style: TextStyle(decoration: TextDecoration.lineThrough)),
                        TextSpan(
                            text: '\$6',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.shopping_cart,
                            color: AppColors.kPrimaryColor,
                          )),
                      InkWell(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: ProductDetailScreen(),
                            withNavBar: true,
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Container(
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppColors.kPrimaryColor,
                              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                          child: Center(
                              child: Text(
                            'view'.tr,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
              height: Get.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/r.jpg'),
                ),
              ),
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
                        Text('5', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  InkWell(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
