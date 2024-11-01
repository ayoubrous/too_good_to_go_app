import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:too_good_to_go_app/controller/product_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/success_screen/success_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/back_end_config.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  dynamic productSnapshotItems = [];
  late ProductController productController;

  @override
  void initState() {
    productController = Get.put(ProductController());
  }

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Cart'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('cart')
                .where('addedBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
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
                  child: Text('someThingWentWrong'.tr, style: Theme.of(context).textTheme.titleMedium),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppColors.kPrimaryColor));
              }
              var data = snapshot.data!.docs;
              productController.calculate(data);
              productController.productSnapshot = data;
              productController.allCartItem(data);
              productController.allcartItemList = data;
              // for remove cart items
              // productSnapshotItems = data;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColors.textFieldGreyColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                    placeholder: (context, url) {
                                      return const Placeholder(
                                        strokeWidth: 0.1,
                                        color: AppColors.textFieldGreyColor,
                                        child: Icon(
                                          Icons.downloading,
                                          color: AppColors.lightRed,
                                        ),
                                      );
                                    },
                                    imageUrl: data[index]['pImage'],
                                  ),
                                ),
                                10.sW,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Product Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(fontWeight: FontWeight.bold, color: AppColors.blackTextColor),
                                      ),
                                      Text(
                                        data[index]['pName'],
                                        style: Theme.of(context).textTheme.bodyLarge,
                                        maxLines: 2,
                                      ),
                                      8.sH,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${data[index]['totalPrice']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('cart')
                                                  .doc(data[index].id)
                                                  .delete();
                                            },
                                            icon: const Icon(
                                              CupertinoIcons.delete,
                                              color: AppColors.kPrimaryColor,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg), color: AppColors.lightRed),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${productController.cartTotalPrice.value.toString()}',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        20.sH,
                        CustomButton(
                          text: 'Buy',
                          onTapped: () async {
                            await makePayment(
                              totalPrice: productController.cartTotalPrice.value.toString(),
                              data: productController.allcartItemList,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }

  Map<String, dynamic>? paymentIntentData;

  // function 1
  Future<void> makePayment({required totalPrice, required List<dynamic> data}) async {
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
      displayPaymentSheet(totalPrice, data);
    } catch (e) {
      print('exception' + e.toString());
    }
  }

  // function 2
  displayPaymentSheet(totalPrice, List<dynamic> data) async {
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
      List<Map<String, dynamic>> orderItems = [];
      for (var doc in data) {
        // setState(() {});
        //orderItems.clear();
        orderItems.add(doc.data() as Map<String, dynamic>);
      }
      // Get.to(
      //       () => GiveReviewScreen(
      //     productID: widget.data['pId'],
      //     businessName: widget.data['pBusinessName'],
      //     productName: widget.data['pName'],
      //   ),
      // );
      /// order collection
      await addOrderToFirestore(orderItems, totalPrice);
      print(orderItems.length);

      // String oderId = BackEndConfig.orderCollection.doc().id;
      // BackEndConfig.orderCollection.doc(oderId).set({
      //   'oder_id': oderId,
      //   'cart_items': data,
      //   // 'uid': FirebaseAuth.instance.currentUser!.uid,
      //   // 'product_id': pId,
      //   // 'total_price': totalPrice,
      //   // 'order_product_image': productImage,
      //   // 'qty': noOfItems,
      //   // 'time': DateFormat('dd-MM-yyyy').format(DateTime.now()),
      // });
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

  Future<void> addOrderToFirestore(List<dynamic> data, String totalPrice) async {
    String orderId = BackEndConfig.orderCollection.doc().id;

    await BackEndConfig.orderCollection.doc(orderId).set({
      'order_id': orderId,
      'cart_items': data,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'total_price': totalPrice,
      'time': DateFormat('dd-MM-yyyy').format(DateTime.now()),
    }).then((value) async {
      Get.to(
        () => SuccessScreen(
        ),
      );
      // for (var item in productController.productSnapshot) {
      //   setState(() {});
      //   //productSnapshotItems.clear();
      //   FirebaseFirestore.instance.collection('cart').doc(item.id).delete();
      // }
      productController.clearCart();
      // await removeOldCartProducts(data);
    });
    print("Order added successfully with ID: $orderId");
  }

// Future<void> removeOldCartProducts(List<dynamic> cartItems) async {
//   List<DocumentReference> cartItemReferences = [];
//   for (var item in cartItems) {
//     cartItemReferences.add(item.reference);
//   }
//
//   await Future.forEach(cartItemReferences, (DocumentReference reference) async {
//     await reference.delete();
//   });
// }
}
