import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/controller/product_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/image_string.dart';
import '../../../../utils/constant/sizes.dart';
import '../../setting_view/my_listing_screen/widget/business_product_card.dart';
import '../product_detail_screen/product_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  final String pName;

  const SearchScreen({super.key, required this.pName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text('search'.tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.sH,
              StreamBuilder(
                stream: controller.searchProduct(pName),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: kToolbarHeight),
                          Text(
                            'NoProductFound'.tr,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: kToolbarHeight / 2),
                          Image.asset(
                            AppImages.notProductYet,
                            width: Get.width * 0.4,
                          ),
                          const SizedBox(height: kToolbarHeight),
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
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data!.docs;
                  var filteredData = data
                      .where((element) => element['pName'].toString().toLowerCase().contains(pName.toLowerCase()))
                      .toList();

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredData.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
                      return BusinessProductCard(
                        isBusinessCard: false,
                        rating: filteredData[index]['rating'].toStringAsFixed(1),
                        pImage: filteredData[index]['pImage'],
                        pName: filteredData[index]['pName'],
                        businessName: filteredData[index]['pBusinessName'],
                        actualPrice: filteredData[index]['pActualPrice'],
                        disPrice: filteredData[index]['pDisPrice'],
                        favIcon: filteredData[index]['p_Whishlist'].contains(FirebaseAuth.instance.currentUser!.uid)
                            ? Iconsax.heart5
                            : Iconsax.heart,
                        favButton: () {
                          if (controller.isFav.value) {
                            /// this is a product id
                            controller.removeFavourite(filteredData[index]['pId'], context);
                            //controller.isFav(false);
                          } else {
                            controller.addToFavourite(filteredData[index]['pId'], context);
                            print(filteredData[index]['pId']);
                            //controller.isFav(true);
                          }
                        },
                        onTapped: () {
                          Get.to(
                            () => ProductDetailScreen(
                              data: filteredData[index],
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
      ),
    );
  }
}
