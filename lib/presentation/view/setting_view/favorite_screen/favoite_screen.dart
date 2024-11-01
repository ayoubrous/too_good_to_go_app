import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/icon_button.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../controller/product_controller.dart';
import '../../../../utils/constant/app_colors.dart';
import '../../home_view/product_detail_screen/product_detail_screen.dart';
import '../my_listing_screen/widget/business_product_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: Text('favourite'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: SingleChildScrollView(
            child: Column(
              children: [
                20.sH,
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(BackEndConfig.kProduct)
                      .where('p_Whishlist', arrayContains: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.kPrimaryColor,
                      ));
                    } else if (snapshot.hasError) {
                      return Text('someThingWentWrong:'.tr + '${snapshot.error}');
                    } else if (snapshot.data!.docs.isEmpty) {
                      return buildIfNoFav(context);
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
                          rating: data['rating'].toStringAsFixed(1),
                          isBusinessCard: false,
                          pImage: data['pImage'],
                          pName: data['pName'],
                          businessName: data['pBusinessName'],
                          actualPrice: data['pActualPrice'].toString(),
                          disPrice: data['pDisPrice'].toString(),
                          favIcon: data['p_Whishlist'].contains(FirebaseAuth.instance.currentUser!.uid)
                              ? Iconsax.heart5
                              : Iconsax.heart,
                          favButton: () {
                            if (controller.isFav.value) {
                              /// this is a product id
                              controller.removeFavourite(data['pId'], context);
                              //controller.isFav(false);
                            } else {
                              controller.addToFavourite(data['pId'], context);
                              print(data['pId']);
                              //controller.isFav(true);
                            }
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
          ),
        ));
  }

  Widget buildIfNoFav(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
      child: Column(
        children: [
          SizedBox(height: kToolbarHeight),
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
    );
  }
}
