import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/filter_screen/filter_screen.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/home_screen/widget/item_card.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../map_screen/map_screen.dart';
import '../product_detail_screen/product_detail_screen.dart';
import '../specific_business_screen/specific_business_screen.dart';
import 'widget/categories_cards.dart';

class HomeScreen extends StatelessWidget {
  List categoryList = [
    [
      'Cafe',
      AppImages.cafe,
    ],
    [
      'Restaurant',
      AppImages.restaurantLogo,
    ],
    [
      'Super Market',
      AppImages.market,
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), // Hide the default AppBar
        child: AppBar(
          backgroundColor: AppColors.kPrimaryColor,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg, vertical: AppSizes.lg),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(AppSizes.borderRadiusLg * 4),
                  ),
                ),
                child: Column(
                  children: [
                    CupertinoButton(
                      pressedOpacity: 0.7,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.to(() => MapScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Iconsax.location,
                            color: AppColors.white,
                            size: AppSizes.iconSm,
                          ),
                          6.sW,
                          Text(
                            'Paris',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                          ),
                          Spacer(),
                          6.sW,
                          const Icon(
                            Iconsax.arrow_down_1,
                            color: AppColors.white,
                            size: AppSizes.iconSm,
                          ),
                        ],
                      ),
                    ),
                    20.sH,
                    CustomTextField(
                      hintText: 'findFood'.tr,
                      isPrefixIcon: true,
                      prefixIcon: Iconsax.search_normal,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () {
                          Get.to(() => FilterScreen());
                        },
                        icon: const Icon(Iconsax.filter),
                        label: Text('filter'.tr),
                        style: TextButton.styleFrom(foregroundColor: AppColors.white),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.sH,
                    Text(
                      'categories'.tr,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    15.sH,
                    SizedBox(
                      height: 96.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          return CategoriesCards(
                            onTap: () {
                              Get.to(() => SpecificBusnessScreen(
                                    businessName: categoryList[index][0],
                                  ));
                            },
                            title: categoryList[index][0],
                            img: categoryList[index][1],
                          );
                        },
                      ),
                    ),
                    15.sH,
                    Text(
                      'recommendedForYou'.tr,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    15.sH,
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) {
                        return ItemCard(
                          onTapp: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: ProductDetailScreen(),
                              withNavBar: false,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: kToolbarHeight * 1.3),
            ],
          ),
        ),
      ),
    );
  }
}
