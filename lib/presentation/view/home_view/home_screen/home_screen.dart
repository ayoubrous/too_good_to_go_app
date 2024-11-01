import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:too_good_to_go_app/controller/location_controller.dart';
import 'package:too_good_to_go_app/controller/product_controller.dart';
import 'package:too_good_to_go_app/controller/profile_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/cart_screen/cart_screen.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/filter_screen/filter_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/exceptions/notification_permission.dart';
import '../../setting_view/my_listing_screen/widget/business_product_card.dart';
import '../map_screen/map_screen.dart';
import '../product_detail_screen/product_detail_screen.dart';
import '../specific_business_screen/specific_business_screen.dart';
import 'search_screen.dart';
import 'widget/categories_cards.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _regPlayerID();
    // NotificationPermision().requestPermission();
    // requestNotificationPermission();
  }

  final storage = const FlutterSecureStorage();

  _regPlayerID() async {
    final tokenID = OneSignal.User.pushSubscription.id;
    if (tokenID != null) {
      String palyeriD = await storage.read(key: "playerID") ?? "";
      if (palyeriD != tokenID) {
        ///update token in firebase
        FirebaseFirestore.instance.collection('tokens').doc(FirebaseAuth.instance.currentUser!.uid).set({
          'id': tokenID,
        }, SetOptions(merge: true)).then((value) {
          storage.write(key: "playerID", value: tokenID);
        });
      }
    }
  }

  sendNotification(String content) async {
    var headers = {
      'Authorization': 'Bearer MzFmZTM5NWEtM2NjYS00NzA3LTg0OTctOGJmZjg2YjdiYzRl',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('https://onesignal.com/api/v1/notifications'));
    request.body = json.encode({
      "app_id": "44629f39-068c-42ad-9d70-95c4954f4c96",
      "include_player_ids": ["5b194f48-4af6-48f6-92f5-6f083bb1fda4"],
      "contents": {"en": content}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final locationController = Get.put(LocationController());
    final profileController = Get.put(ProfileController());
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: AppColors.kPrimaryColor,
            elevation: 0,
          ),
        ),
        body: profileController.isBlocked.value
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'youareblockedduetosomereason'.tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: kToolbarHeight),
                      const Icon(
                        Icons.block,
                        color: AppColors.kPrimaryColor,
                        size: AppSizes.iconLg,
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
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
                            Row(
                              children: [
                                CupertinoButton(
                                  pressedOpacity: 0.7,
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Get.to(() => const MapScreen());
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
                                      Obx(
                                        () => Text(
                                          locationController.address.value.toString(),
                                          style:
                                              Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('cart')
                                      .where(
                                        'addedBy',
                                        isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                                      )
                                      .snapshots(),
                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    int cartItemCount = snapshot.data?.docs.length ?? 0;

                                    return IconButton(
                                      onPressed: () {
                                        Get.to(() => const CartScreen());
                                      },
                                      icon: Badge(
                                        backgroundColor: AppColors.white,
                                        label: Text(
                                          cartItemCount.toString(),
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                        child: const Icon(
                                          Iconsax.shopping_cart,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            20.sH,
                            CustomTextField(
                              controller: controller.searchedController,
                              onFieldSubmitted: (value) {
                                controller.searchedController.text = value;
                                if (controller.searchedController.text.isNotEmpty) {
                                  Get.to(
                                    () => SearchScreen(
                                      pName: controller.searchedController.text,
                                    ),
                                  );
                                }
                              },
                              hintText: 'findFood'.tr,
                              isPrefixIcon: true,
                              prefixIcon: Iconsax.search_normal,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                onPressed: () {
                                  Get.to(
                                    () => FilterScreen(),
                                  );
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
                            StreamBuilder<QuerySnapshot>(
                              stream:
                                  FirebaseFirestore.instance.collection(BackEndConfig.kBusinessCategory).snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.data?.docs.isEmpty ?? true) {
                                  return Center(
                                    child: Text(
                                      'noDataAddedYet'.tr,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                    child:
                                        Text('someThingWentWrong'.tr, style: Theme.of(context).textTheme.titleMedium),
                                  );
                                }
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator(color: AppColors.kPrimaryColor));
                                }
                                return SizedBox(
                                  height: 104.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final data = snapshot.data!.docs[index];
                                      return Center(
                                        child: CategoriesCards(
                                          onTap: () {
                                            Get.to(() => SpecificBusnessScreen(
                                                  Catid: data['businessCatId'],
                                                  CatName: data['name'],
                                                ));
                                          },
                                          title: data['name'],
                                          img: data['image'],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            15.sH,
                            Text(
                              'recommendedForYou'.tr,
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            15.sH,
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(BackEndConfig.kProduct)
                                  .orderBy('pName', descending: false)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: kToolbarHeight),
                                        Text(
                                          'noProductHaveBeenAddedYet'.tr,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontWeight: FontWeight.bold),
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
                                return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.68,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                  ),
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data!.docs[index];
                                    return BusinessProductCard(
                                      id: data.id.toString(),
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
                                          controller.removeFavourite(
                                              snapshot.data!.docs[index]['pId'].toString(), context);
                                          //controller.isFav(false);
                                        } else {
                                          controller.addToFavourite(
                                              snapshot.data!.docs[index]['pId'].toString(), context);
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
                      const SizedBox(height: kToolbarHeight * 1.3),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

// FirebaseFirestore.instance
//     .collection('videos')
//     .where('uid',isEqualTo: widget.uid)
//     .get()
//     .then((QuerySnapshot querySnapshot) {
// Print(querySnapshot.size);
// });
}
