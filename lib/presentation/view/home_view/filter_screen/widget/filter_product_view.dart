import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';

import '../../../../../controller/product_controller.dart';
import '../../../setting_view/my_listing_screen/widget/business_product_card.dart';
import '../../product_detail_screen/product_detail_screen.dart';

class FilterProductView extends StatelessWidget {
  final Stream<List<dynamic>> filterProductList;

  FilterProductView({super.key, required this.filterProductList});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: StreamBuilder(
          stream: filterProductList,
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error.toString()}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
            final List<dynamic>? products = snapshot.data;
            if (products == null || products.isEmpty) {
              return const Center(
                child: Text('No Product Found'),
              );
            }

            return GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                return BusinessProductCard(
                  isBusinessCard: false,
                  rating: products[index]['rating'].toStringAsFixed(1),
                  pImage: products[index]['pImage'],
                  pName: products[index]['pName'],
                  businessName: products[index]['pBusinessName'],
                  actualPrice: products[index]['pActualPrice'].toString(),
                  disPrice: products[index]['pDisPrice'].toString(),
                  favIcon: products[index]['p_Whishlist'].contains(FirebaseAuth.instance.currentUser!.uid)
                      ? Iconsax.heart5
                      : Iconsax.heart,
                  favButton: () {
                    if (controller.isFav.value) {
                      /// this is a product id
                      controller.removeFavourite(products[index].id, context);
                      //controller.isFav(false);
                    } else {
                      controller.addToFavourite(products[index].id, context);
                      print(products[index].id);
                      //controller.isFav(true);
                    }
                  },
                  onTapped: () {
                    Get.to(
                      () => ProductDetailScreen(
                        data: products[index],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
