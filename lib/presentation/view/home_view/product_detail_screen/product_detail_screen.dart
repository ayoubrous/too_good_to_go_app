import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:share/share.dart';
import 'package:too_good_to_go_app/controller/product_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/loaders.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../controller/localization_controller.dart';
import '../../../elements/dialog_box.dart';
import '../../../elements/icon_button.dart';
import '../give_review_screen/give_review_screen.dart';
import '../review_screen/review_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic data;

  ProductDetailScreen({
    super.key,
    this.data,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    _getReviews(widget.data['pId']);
  }

  List reviews = [];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocalizationController());
    final productController = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        productController.clearAfterAddToCart();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: widget.data.id.toString(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.blackTextColor.withOpacity(0.5), blurRadius: 15, offset: const Offset(0, 5))
                    ],
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppSizes.borderRadiusLg * 2)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.data['pImage'],
                      ),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: CircleAvatar(
                                backgroundColor: AppColors.textFieldGreyColor,
                                child: BackButton(
                                  onPressed: () {
                                    productController.clearAfterAddToCart();
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    iconSize: MaterialStatePropertyAll<double>(20),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            CustomIconButton(
                              onTapp: () {
                                shareProduct();
                              },
                              iconColor: AppColors.kPrimaryColor,
                              iconData: Icons.share_outlined,
                            ),
                            8.sW,

                            /// heart
                            CustomIconButton(
                              onTapp: () {
                                if (productController.isFav.value) {
                                  /// this is a product id
                                  productController.removeFavourite(widget.data.id, context);
                                  //controller.isFav(false);
                                } else {
                                  productController.addToFavourite(widget.data.id, context);
                                  print(widget.data.id);
                                  //controller.isFav(true);
                                }
                              },
                              iconColor: AppColors.yellowColor,
                              iconData: widget.data['p_Whishlist'].contains(FirebaseAuth.instance.currentUser!.uid)
                                  ? Iconsax.heart5
                                  : Iconsax.heart,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                              child: ColoredBox(
                                color: AppColors.blackTextColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
                                  child: Text(
                                    "${widget.data['pTotalItemLeft']}" + "\t" + "left".tr,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                  ),
                                ),
                              ),
                            ),
                            15.sW,
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: 60,
                                height: 60,
                                imageUrl: widget.data['pBusinessImage'],
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
                          ],
                        )
                      ],
                    ),
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
                          widget.data['pBusinessName'],
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${widget.data['pActualPrice']}',
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
                          widget.data['pName'],
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Text(
                          '\$${widget.data['pDisPrice']}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor, fontSize: 16),
                        )
                      ],
                    ),
                    10.sH,
                    Text(
                      'description'.tr,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.data['pDescription'],
                      maxLines: 3,
                    ),
                    10.sH,
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'selectQuantity'.tr,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              productController.decrementQuantity();
                              productController.calculateTotalPrice(int.parse(widget.data['pDisPrice']));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: AppColors.kPrimaryColor.withOpacity(0.5)),
                              child: const Icon(
                                Iconsax.minus,
                                color: AppColors.white,
                                size: AppSizes.iconSm,
                              ),
                            ),
                          ),
                          8.sW,
                          Text(
                            productController.item.value.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          8.sW,
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              productController.incrementQuantity(int.parse(widget.data['pTotalItemLeft']));
                              productController.calculateTotalPrice(int.parse(widget.data['pDisPrice']));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.kPrimaryColor),
                              child: const Icon(
                                Iconsax.add,
                                color: AppColors.white,
                                size: AppSizes.iconSm,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    15.sH,
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
                          '${widget.data['pStartTime'].toString()} - ${widget.data['pEndTime'].toString()}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    10.sH,
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: widget.data['rating'],
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
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
                              screen: ReviewScreen(
                                productId: widget.data['pId'],
                              ),
                              withNavBar: true,
                            );

                            // Get.to(() => ReviewScreen());
                          },
                          child: Text(
                            '${widget.data['rating'].toStringAsFixed(1)} (${reviews.isEmpty ? "0" : reviews.length.toString()})'
                                    " " +
                                'review'.tr,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    5.sW,
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
                      label: Text(
                        widget.data['foodType'],
                        style: const TextStyle(color: AppColors.white),
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
                                '${widget.data['rating'].toStringAsFixed(1)}/5.0',
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
                    30.sH,
                    // buy button
                    CustomButton(
                      text: 'Add To Cart',
                      onTapped: () {
                        if (productController.item.value > 0) {
                          FirebaseFirestore.instance.collection('cart').doc().set({
                            'pName': widget.data['pName'],
                            'pImage': widget.data['pImage'],
                            'pId': widget.data['pId'],
                            'isReviewed': false,
                            'businessName': widget.data['pBusinessName'],
                            'addedBy': FirebaseAuth.instance.currentUser!.uid,
                            'qty': productController.item.value.toString(),
                            'totalPrice': productController.totalPrice.value.toString(),
                          }).then((value) {
                            print(widget.data['pId']);
                            print(widget.data['pBusinessName']);
                            BLoaders.successSnackBar(
                              title: 'Successfully',
                              messagse: 'Add in to cart',
                            );
                          });
                        } else {
                          BLoaders.warningSnackBar(title: 'Item', messagse: 'Select Atleast Minimum 1 Item');
                        }
                      },
                    ),

                    // 60.sH,
                    // CustomButton(
                    //   onTapped: () {
                    //     Get.bottomSheet(
                    //       backgroundColor: AppColors.white,
                    //       shape: const RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadiusLg))),
                    //       Container(
                    //         padding: const EdgeInsets.all(12),
                    //         child: Column(
                    //           mainAxisSize: MainAxisSize.min,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Image.asset(
                    //               AppImages.appLogo,
                    //               width: 70,
                    //             ),
                    //             20.sH,
                    //             const Divider(),
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //               children: [
                    //                 Text(
                    //                   'selectQuantity'.tr,
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .titleMedium!
                    //                       .copyWith(fontWeight: FontWeight.bold),
                    //                 ),
                    //                 Obx(
                    //                   () => Text(
                    //                     "\$${productController.totalPrice.value.toString()}",
                    //                     style: Theme.of(context)
                    //                         .textTheme
                    //                         .bodyLarge!
                    //                         .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             15.sH,
                    //             Obx(
                    //               () => Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   IconButton(
                    //                     style: IconButton.styleFrom(
                    //                         backgroundColor: AppColors.kPrimaryColor.withOpacity(0.5)),
                    //                     color: AppColors.kPrimaryColor,
                    //                     onPressed: () {
                    //                       productController.decrementQuantity();
                    //                       productController.calculateTotalPrice(int.parse(widget.data['pDisPrice']));
                    //                     },
                    //                     icon: const Icon(
                    //                       Iconsax.minus,
                    //                       color: AppColors.textFieldGreyColor,
                    //                     ),
                    //                   ),
                    //                   8.sW,
                    //                   Text(
                    //                     productController.item.value.toString(),
                    //                     style: Theme.of(context)
                    //                         .textTheme
                    //                         .bodyLarge!
                    //                         .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    //                   ),
                    //                   8.sW,
                    //                   IconButton(
                    //                     style: IconButton.styleFrom(backgroundColor: AppColors.kPrimaryColor),
                    //                     color: AppColors.kPrimaryColor,
                    //                     onPressed: () {
                    //                       productController.incrementQuantity(int.parse(widget.data['pTotalItemLeft']));
                    //                       productController.calculateTotalPrice(int.parse(widget.data['pDisPrice']));
                    //                     },
                    //                     icon: const Icon(
                    //                       Iconsax.add,
                    //                       color: AppColors.textFieldGreyColor,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             20.sH,
                    //             Padding(
                    //               padding: const EdgeInsets.symmetric(horizontal: 100),
                    //               child: CustomButton(
                    //                 text: 'pay'.tr,
                    //                 onTapped: () async {
                    //                   if (productController.item.value > 0) {
                    //                     await makePayment(
                    //                         productController.totalPrice.value, productController.item.value);
                    //                     Get.back();
                    //                     productController.item.value = 0;
                    //                     productController.totalPrice.value = 0;
                    //                   } else {
                    //                     BLoaders.warningSnackBar(
                    //                         title: 'Item', messagse: 'Select Atleast Minimum 1 Item');
                    //                   }
                    //
                    //                   // PersistentNavBarNavigator.pushNewScreen(
                    //                   //   context,
                    //                   //   screen: GiveReviewScreen(
                    //                   //     productID: widget.data['pId'],
                    //                   //     businessName: widget.data['pBusinessName'],
                    //                   //     productName: widget.data['pName'],
                    //                   //   ),
                    //                   //   withNavBar: true,
                    //                   //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    //                   // );
                    //                 },
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   text: 'buy'.tr,
                    // ),
                  ],
                ),
              ),
              20.sH,
            ],
          ),
        ),
      ),
    );
  }

  _getReviews(productId) async {
    await FirebaseFirestore.instance
        .collection("reviews")
        .where('productID', isEqualTo: productId)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      reviews.clear();
      snapshot.docs.forEach((element) {
        setState(() {});
        reviews.add(element);
        setState(() {});
      });
    });
  }

  /// Stripe
  Map<String, dynamic>? paymentIntentData;

  // function 1
  Future<void> makePayment(totalPrice, noOfItems) async {
    try {
      paymentIntentData = await createPaymentIntent(totalPrice.toString(), 'USD');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            // applePay: PaymentSheetApplePay(
            //   merchantCountryCode: 'US',
            // ),
            merchantDisplayName: 'BASIT'),
      );
      // display sheet
      displayPaymentSheet(totalPrice, noOfItems);
    } catch (e) {
      print('exception' + e.toString());
    }
  }

  // function 2
  displayPaymentSheet(totalPrice, noOfItems) async {
    try {
      await Stripe.instance.presentPaymentSheet(
        options: const PaymentSheetPresentOptions(),
      );
      setState(() {
        paymentIntentData = null;
      });

      Get.snackbar(
        'Success',
        'Paid Successfully',
        isDismissible: true,
        shouldIconPulse: true,
        colorText: AppColors.white,
        backgroundColor: AppColors.kGreenColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(8),
        icon: const Icon(Icons.done_all, color: AppColors.white),
      );
      // Get.to(
      //   () => GiveReviewScreen(
      //     productID: widget.data['pId'],
      //     businessName: widget.data['pBusinessName'],
      //     productName: widget.data['pName'],
      //   ),
      // );

      /// order collection
      String oderId = BackEndConfig.orderCollection.doc().id;
      BackEndConfig.orderCollection.doc(oderId).set({
        'oder_id': oderId,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'product_id': widget.data['pId'],
        'total_price': totalPrice,
        'order_product_image': widget.data['pImage'],
        'qty': noOfItems,
        'time': DateFormat('dd-MM-yyyy').format(DateTime.now()),
      });
    } on StripeException catch (e) {
      print(e.toString());
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text('error'.tr),
          content: const Text('Cancel'),
        ),
      );
    }
  }

  // function 3
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'), body: body, headers: {
        'Authorization':
            'Bearer sk_test_51O2bQ9HNCdxitP0OOFo3cCnKKiw3zBURyyBNr6MkDyiK8jIjn4pqzCfyLMQBsJ6Qca9HOTDVlzo3DDYXW8GeubBG004tEgSmZZ',
        'Content-Type': 'application/x-www-form-urlencoded'
      });
      return jsonDecode(response.body.toString());
    } catch (e) {
      print('exception' + e.toString());
    }
  }

  // function 4
  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }

  void shareProduct() {
    final productDetails = widget.data;
    final productName = productDetails['pName'];
    final productDescription = productDetails['pDescription'];
    final productImage = productDetails['pImage'];
    final productLink =
        'https://yourapp.com/products/${productDetails['pId']}';

    final shareContent = '''
    Check out this product!

    Name: $productName
    Description: $productDescription
    Image: $productImage
    Link: $productLink
    ''';

    Share.share(shareContent);
  }
}
