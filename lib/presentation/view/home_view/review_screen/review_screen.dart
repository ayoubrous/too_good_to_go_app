import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/user_placeholder_image_widget.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/image_string.dart';
import '../../../elements/image_builder_widget.dart';

class ReviewScreen extends StatefulWidget {
  final String productId;

  const ReviewScreen({super.key, required this.productId});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text('review'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.sH,
              StreamBuilder(
                stream: BackEndConfig.reviewCollection.where('productID', isEqualTo: widget.productId).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: kToolbarHeight),
                          Text(
                            'noReviewForThisProduct'.tr,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: kToolbarHeight / 2),
                          Image.asset(
                            AppImages.review,
                            height: Get.width * 0.8,
                          ),
                          const SizedBox(height: kToolbarHeight),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    Center(
                      child: Text(
                        'someThingWentWrong'.tr,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        var data = snapshot.data!.docs[i];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                data['userImage'] != ''
                                    ? Center(
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          height: Get.width * 0.12,
                                          width: Get.width * 0.12,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle, color: AppColors.textFieldGreyColor),
                                          child: ImageBuilderWidget(
                                            image: data['userImage'].toString(),
                                          ),
                                        ),
                                      )
                                    : UserPlaceHolderWidget(
                                        width: Get.width * 0.12,
                                      ),
                                10.sW,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['username'] ?? 'User Name',
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    RatingBar.builder(
                                      initialRating: data['rating'],
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ignoreGestures: true,
                                      itemSize: AppSizes.iconSm,
                                      itemBuilder: (context, _) => const Icon(
                                        Iconsax.star,
                                        color: AppColors.yellowColor,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            5.sH,
                            ReadMoreText(
                              data['comment'],
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: 12,
                                    color: AppColors.textFieldGreyColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                              trimLines: 2,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'show more',
                              moreStyle: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
                              lessStyle: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
                              trimExpandedText: 'show less',
                            ),
                            Divider(),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getReviews();
  }

  List reviews = [];

  _getReviews() async {
    await FirebaseFirestore.instance.collection("reviews").snapshots().listen((QuerySnapshot snapshot) {
      reviews.clear();
      snapshot.docs.forEach((element) {
        setState(() {});
        reviews.add(element);
        setState(() {});
      });
    });
  }
}
