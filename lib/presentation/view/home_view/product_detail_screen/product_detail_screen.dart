import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../controller/localization_controller.dart';
import '../../../elements/dialog_box.dart';
import '../../../elements/icon_button.dart';
import '../give_review_screen/give_review_screen.dart';
import '../review_screen/review_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocalizationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppSizes.borderRadiusLg)),
                  image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/r.jpg'))),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircleAvatar(
                            backgroundColor: AppColors.textFieldGreyColor,
                            child: BackButton(
                              style: ButtonStyle(
                                iconSize: MaterialStatePropertyAll<double>(20),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        CustomIconButton(
                          onTapp: () {},
                          iconColor: AppColors.kPrimaryColor,
                          iconData: Iconsax.share,
                        ),
                        8.sW,
                        CustomIconButton(
                          onTapp: () {},
                          iconColor: AppColors.yellowColor,
                          iconData: Iconsax.heart5,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ColoredBox(
                          color: AppColors.blackTextColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
                            child: Text(
                              '1 left',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                        15.sW,
                        const CircleAvatar(
                          radius: 25,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  15.sH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Restaurant Name',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$30',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item Name',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Text(
                        '\$10',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor, fontSize: 16),
                      )
                    ],
                  ),
                  10.sH,
                  Row(
                    children: [
                      const Icon(
                        Iconsax.clock,
                        color: AppColors.kPrimaryColor,
                        size: AppSizes.iconMd,
                      ),
                      8.sW,
                      Text(
                        'collectTime'.tr + " " + " ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '11:45 - 12:25',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  10.sH,
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemSize: AppSizes.iconMd,
                        itemBuilder: (context, _) => const Icon(
                          Iconsax.star,
                          color: AppColors.yellowColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      5.sW,
                      InkWell(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const ReviewScreen(),
                            withNavBar: true,
                          );

                          //Get.to(() => ReviewScreen());
                        },
                        child: Text(
                          '4.0 (150)' + " " + 'review'.tr,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      5.sW,
                    ],
                  ),
                  15.sH,
                  const Divider(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    minSize: 20,
                    pressedOpacity: 0.6,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const DialogBox();
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ingredientsAllergens'.tr,
                          style: const TextStyle(color: AppColors.kPrimaryColor),
                        ),
                        Icon(
                          controller.isArabic.value
                              ? Icons.keyboard_arrow_left_sharp
                              : Icons.keyboard_arrow_right_outlined,
                          size: 30,
                          color: AppColors.kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: const Text(
                      'Bakery',
                      style: TextStyle(color: AppColors.white),
                    ),
                    labelPadding: EdgeInsets.zero,
                    backgroundColor: AppColors.kPrimaryColor.withOpacity(0.3),
                  ),
                  const Divider(),
                  15.sH,
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'whatOtherPeopleAreSaying'.tr,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        8.sH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Iconsax.star,
                              color: AppColors.kPrimaryColor,
                            ),
                            10.sW,
                            Text(
                              '4.1/5.0',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  10.sH,
                  Text(
                    'whatYouNeedToKnow'.tr,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'whatYouNeedToKnowSubTitle'.tr,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const SizedBox(height: kToolbarHeight * 2),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomButton(
          onTapped: () {
            Get.bottomSheet(
              backgroundColor: AppColors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadiusLg))),
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.appLogo,
                      width: 70,
                    ),
                    20.sH,
                    const Divider(),
                    Text(
                      'selectQuantity'.tr,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'limitPerCustomer'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    15.sH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 2,
                          shadowColor: Colors.transparent,
                          color: AppColors.kPrimaryColor.withOpacity(0.3),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Iconsax.minus,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                        8.sW,
                        Text(
                          '0',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        8.sW,
                        const Card(
                          color: AppColors.kPrimaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Iconsax.add,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.sH,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: CustomButton(
                        text: 'add'.tr,
                        onTapped: () {
                          /// add a payment dialog before give review screen..
                          Get.back();
                          Get.to(() => const GiveReviewScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          text: 'addTocart'.tr,
        ),
      ),
    );
  }
}
