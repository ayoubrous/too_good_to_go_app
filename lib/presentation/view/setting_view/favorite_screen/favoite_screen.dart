import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/icon_button.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/app_colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title:  Text('favourite'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            children: [
              20.sH,
              // GridView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: 2,
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     childAspectRatio: 0.75,
              //     crossAxisCount: 2,
              //     mainAxisSpacing: 15,
              //     crossAxisSpacing: 15,
              //   ),
              //   itemBuilder: (context, index) {
              //     return ItemCard(
              //       onTapp: () {
              //         PersistentNavBarNavigator.pushNewScreen(
              //           context,
              //           screen: const RestaurantDetailScreen(),
              //           withNavBar: false,
              //         );
              //         // NavigationHelper.pushRoute(context, RestaurantDetailScreen());
              //       },
              //     );
              //   },
              // ),
              10.sH,
              // when no item is found than show these below
              Column(
                children: [
                  Text(
                    'noFavouriteAddedYet'.tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'favouriteSubTitle'.tr,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  30.sH,
                  const Padding(
                    padding: EdgeInsets.only(left: 76.0),
                    child: Icon(
                      Icons.arrow_downward,
                      color: AppColors.kPrimaryColor,
                      size: AppSizes.iconLg,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 150,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 160,
                            width: 180,
                            decoration: BoxDecoration(
                              color: AppColors.greyColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(right: 8, left: 8, bottom: 15),
                            height: 100,
                            width: 180,
                            decoration: BoxDecoration(
                              color: AppColors.textFieldGreyColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Align(
                              alignment: Alignment.topRight,
                              child: CustomIconButton(
                                circleColor: AppColors.white,
                                iconColor: AppColors.yellowColor,
                                iconData: Iconsax.heart,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
