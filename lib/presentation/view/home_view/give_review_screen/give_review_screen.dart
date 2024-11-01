import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_loaders.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/loaders.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../elements/custom_back_button.dart';
import '../../../elements/user_placeholder_image_widget.dart';
import '../success_screen/success_screen.dart';

class GiveReviewScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final String orderId;

  const GiveReviewScreen({super.key, required this.product, required this.orderId});

  // final String productID;
  // final String productName;
  // final String businessName;
  //
  // const GiveReviewScreen({super.key, required this.productID, required this.productName, required this.businessName});

  @override
  State<GiveReviewScreen> createState() => _GiveReviewScreenState();
}

class _GiveReviewScreenState extends State<GiveReviewScreen> {
  @override
  void initState() {
    super.initState();
    _getRatings();
    getUser();
  }

  double userRating = 2.0;
  TextEditingController comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: Text('thankyouForOrdering'.tr),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.sH,
                userImage != ''
                    ? Center(
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          height: Get.width * 0.25,
                          width: Get.width * 0.25,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.textFieldGreyColor),
                          child: CachedNetworkImage(
                            imageUrl: userImage.toString(),
                          ),
                        ),
                      )
                    : UserPlaceHolderWidget(),
                20.sH,
                Text(
                  'businessName'.tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
                Text(
                  //widget.product['pName'],
                  widget.product['businessName'].toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                10.sH,
                Text(
                  'productName'.tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
                Text(
                  widget.product['pName'].toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                20.sH,
                Center(
                  child: RatingBar.builder(
                    initialRating: userRating,
                    glow: false,
                    itemPadding: EdgeInsets.all(10),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    ignoreGestures: false,
                    itemSize: AppSizes.iconLg,
                    itemBuilder: (context, _) => const Icon(
                      Iconsax.star,
                      color: AppColors.yellowColor,
                    ),
                    onRatingUpdate: (rating) {
                      userRating = rating;
                      setState(() {});
                    },
                  ),
                ),
                10.sH,
                TextFormField(
                  controller: comment,
                  maxLength: null,
                  maxLines: null,
                  decoration: InputDecoration(hintText: 'yourComment'.tr),
                ),
                25.sH,
                CustomButton(
                  text: 'sayIt'.tr,
                  onTapped: () {
                    _addReview(true);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? userImage;
  String? name;
  bool isLoading = false;

  makeLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  makeLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  getUser() {
    BackEndConfig.userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      setState(() {});
      userImage = snapshot.get('image');
      name = snapshot.get('name');
    });
  }

  // _addReview(isReviewed) async {
  //   makeLoadingTrue();
  //   await FirebaseFirestore.instance.collection("reviews").doc().set({
  //     "productID": widget.product['pId'],
  //     "comment": comment.text.toString(),
  //     "rating": userRating,
  //     "username": name == '' ? 'Name' : name,
  //     'isReviews': isReviewed,
  //     "userImage": userImage.toString(),
  //     "userID": FirebaseAuth.instance.currentUser!.uid,
  //   }).then((value) async {
  //     makeLoadingFalse();
  //     // Navigator.pushReplacement(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //       builder: (_) => SuccessScreen(),
  //     //     ));
  //     clearAllField();
  //     double averageRating = 0.0;
  //     // print("ahsdasdasdad ${ratings.length}");
  //     if (ratings.isNotEmpty) {
  //       averageRating = ratings.reduce((a, b) => a + b) / ratings.length;
  //     } else {
  //       averageRating = userRating; // Set to 0 if there are no ratings yet
  //     }
  //     FirebaseFirestore.instance
  //         .collection("products")
  //         .doc(widget.product['pId'])
  //         .set({"rating": averageRating}, SetOptions(merge: true));
  //   });
  // }
  _addReview(bool isReviewed) async {
    makeLoadingTrue();

    String userId = FirebaseAuth.instance.currentUser!.uid;
    String productId = widget.product['pId'];

    await FirebaseFirestore.instance.collection("reviews").doc().set({
      "productID": productId,
      "comment": comment.text.toString(),
      "rating": userRating,
      "username": name == '' ? 'Name' : name,
      'isReviews': isReviewed,
      "userImage": userImage.toString(),
      "userID": userId,
    }).then((value) async {
      double averageRating = 0.0;
      if (ratings.isNotEmpty) {
        averageRating = ratings.reduce((a, b) => a + b) / ratings.length;
      } else {
        averageRating = userRating;
      }

      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .set({"rating": averageRating}, SetOptions(merge: true));

      // Update the 'reviewed' status in the 'orders' collection
      String orderId = widget.orderId; // Make sure you pass orderId to this widget
      var orderDoc = FirebaseFirestore.instance.collection('order').doc(orderId);
      var orderSnapshot = await orderDoc.get();
      var cartItems = List<Map<String, dynamic>>.from(orderSnapshot['cart_items']);

      for (var item in cartItems) {
        if (item['pId'] == productId) {
          item['isReviewed'] = true;
          break;
        }
      }

      await orderDoc.update({'cart_items': cartItems});

      makeLoadingFalse();
      clearAllField();

      BLoaders.successSnackBar(title: 'Success', messagse: 'Review submitted successfully');
    }).catchError((error) {
      makeLoadingFalse();
      BLoaders.errorSnackBar(title: 'Error', messagse: 'Failed to submit review. Please try again.');
    });
  }

  List<double> ratings = [];

  _getRatings() async {
    await FirebaseFirestore.instance.collection("reviews").snapshots().listen((QuerySnapshot snapshot) {
      ratings.clear();
      snapshot.docs.forEach((element) {
        ratings.add(element["rating"]);
        setState(() {});
      });
    });
  }

  clearAllField() {
    comment.clear();
    userRating = 2;
    setState(() {});
  }
}
