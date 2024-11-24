import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:too_good_to_go_app/controller/product_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/success_screen/success_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/loaders.dart';
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
    Timer.periodic(Duration(minutes: 10), (timer) {
      checkForExpiredCartItems();
    });
  }

  Stream<QuerySnapshot> getCartItems() {
    // final now = DateTime.now();
    // final thirtyMinutesAgo = Timestamp.fromDate(now.subtract(Duration(minutes: 30)));

    return FirebaseFirestore.instance
        .collection('cart')
        .where('addedBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // void deleteExpiredCartItems() async {
  //   try {
  //     final now = DateTime.now();
  //     final thirtyMinutesAgo = Timestamp.fromDate(now.add(Duration(minutes: 2)));
  //
  //     final cartSnapshot = await FirebaseFirestore.instance
  //         .collection('cart')
  //         .where('addedBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //
  //     for (var doc in cartSnapshot.docs) {
  //       final timestamp = doc['timestamp'];
  //
  //       if (timestamp == null) {
  //         print("Cart item ${doc.id} is missing a timestamp.");
  //         continue;
  //       }
  //
  //       if (timestamp.toDate().isBefore(thirtyMinutesAgo.toDate())) {
  //         await FirebaseFirestore.instance.collection('cart').doc(doc.id).delete();
  //         print('Deleted expired cart item: ${doc.id}');
  //       }
  //     }
  //
  //     BLoaders.warningSnackBar(
  //       title: 'Alert',
  //       messagse: 'Items in your cart have been removed after exceeding the 30-minute limit.',
  //     );
  //   } catch (e) {
  //     print("Error while deleting expired cart items: $e");
  //   }
  // }

  /// 1 chat gpt ///
  // void checkForExpiredCartItems() {
  //   FirebaseFirestore.instance
  //       .collection('cart')
  //       .where('addedBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .snapshots()
  //       .listen((snapshot) async {
  //     final now = DateTime.now();
  //     final thirtyMinutesAgo = Timestamp.fromDate(now.subtract(Duration(minutes: 2)));
  //
  //     for (var doc in snapshot.docs) {
  //       final timestamp = doc['timestamp'] as Timestamp?;
  //       if (timestamp != null && timestamp.toDate().isBefore(thirtyMinutesAgo.toDate())) {
  //         print(doc['timestamp']);
  //         // Delete expired cart item
  //         await FirebaseFirestore.instance.collection('cart').doc(doc.id).delete();
  //         print('Deleted expired cart item: ${doc.id}');
  //       }
  //     }
  //   });
  // }

  void checkForExpiredCartItems() {
    // Access the current user ID from FirebaseAuth
    final userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('cart')
        .where('addedBy', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) async {
      final now = DateTime.now();
      final thirtyMinutesAgo = Timestamp.fromDate(now.subtract(Duration(minutes: 30)));

      List<Future> deleteTasks = [];

      for (var doc in snapshot.docs) {
        final timestamp = doc['timestamp'] as Timestamp?;

        if (timestamp != null && timestamp.toDate().isBefore(thirtyMinutesAgo.toDate())) {
          print("Item with timestamp ${doc['timestamp']} has expired.");

          deleteTasks.add(FirebaseFirestore.instance.collection('cart').doc(doc.id).delete());
        }
      }

      await Future.wait(deleteTasks);
      print("Deleted all expired cart items.");
    });
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
            stream: getCartItems(),
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
              productController.allcartItemList = data.cast<Map<String, dynamic>>();

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
                          height: Get.height * 0.18,
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
                                  height: Get.height * 0.12,
                                  margin: const EdgeInsets.only(left: 8),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      Text(
                                        "Qty:${data[index]['qty']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: AppColors.blackTextColor),
                                        maxLines: 2,
                                      ),
                                      // 8.sH,
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
                              // pStartTime: '',
                              // pEndTime: '',
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
  Future<void> makePayment({
    required totalPrice,
    required List<dynamic> data,
    // pStartTime,
    // pEndTime,
  }) async {
    try {
      paymentIntentData = await createPaymentIntent(totalPrice.toString(), 'USD');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'], merchantDisplayName: 'BASIT'),
      );
      // display sheet
      displayPaymentSheet(totalPrice, data);
    } catch (e) {
      print('exception' + e.toString());
    }
  }

  ///----------------///

  String generateOTP(int length) {
    final random = Random();
    const characters = '0123456789';
    return List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
  }

  displayPaymentSheet(
    totalPrice,
    List<dynamic> data,
  ) async {
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
        var itemData = doc.data() as Map<String, dynamic>;

        itemData['otp'] = generateOTP(4);
        itemData['isOTPObscure'] = true;
        orderItems.add(itemData);
      }

      /// Save the order collection to Firestore
      await addOrderToFirestore(orderItems, totalPrice);

      print(orderItems.length);
      print(orderItems);
    } on StripeException catch (e) {
      print(e.toString());

      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        context: context,
        builder: (_) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Payment Failed',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Text(
                'Please try again or choose an option.',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.kPrimaryColor,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    await displayPaymentSheet(
                      totalPrice,
                      data,
                    );
                  },
                  child: const Text('Retry Payment'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.kPrimaryColor,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.to(() => const CartScreen());
                  },
                  child: Text('Back to Cart'.tr),
                ),
              ),
            ],
          ),
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

  /// ---------done one---------- ///
  Future<void> addOrderToFirestore(
    List<dynamic> data,
    String totalPrice,
  ) async {
    try {
      String orderId = BackEndConfig.orderCollection.doc().id;

      // Generate a random 4-digit OTP
      String generateOTP() {
        final random = Random();
        return (1000 + random.nextInt(9000)).toString();
      }

      String otp = generateOTP();
      DateTime expiryTime = DateTime.now().add(Duration(minutes: 15));

      // Add the order along with OTP and expiration time
      await BackEndConfig.orderCollection.doc(orderId).set({
        'order_id': orderId,
        'cart_items': data,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'total_price': totalPrice.toString(),
        'time': DateFormat('dd-MM-yyyy').format(DateTime.now()),
        // 'otp': otp,
        'isScanned': false,
        'expiryTime': expiryTime.toIso8601String(),
      });

      // Navigate to the success screen
      Get.to(() => SuccessScreen());

      // Clear the cart
      productController.clearCart();

      // Display the OTP to the user
      Get.snackbar(
        'Order Placed',
        'Your OTP is: $otp\nPlease show it at the store.',
        isDismissible: true,
        shouldIconPulse: true,
        colorText: AppColors.white,
        backgroundColor: AppColors.kGreenColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(8),
        icon: const Icon(Icons.done_all, color: AppColors.white),
      );
      print("Order added successfully with ID: $orderId and OTP: $otp");
    } catch (e) {
      print("Error adding order: $e");
    }
  }
}
