import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/success_screen/success_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../elements/custom_back_button.dart';

class GiveReviewScreen extends StatelessWidget {
  const GiveReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title:  Text('thankyouForOrdering'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.sH,
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.textFieldGreyColor),
                ),
              ),
              20.sH,
              Text(
                'Restaurant Name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Item Name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              20.sH,
              Center(
                child: RatingBar.builder(
                  initialRating: 2,
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
                  onRatingUpdate: (rating) {},
                ),
              ),
              10.sH,
              TextFormField(
                maxLength: 100,
                maxLines: null,
                decoration: InputDecoration(hintText: 'yourComment'.tr),
              ),
              25.sH,
              CustomButton(
                text: 'sayIt'.tr,
                onTapped: () {
                  Get.to(() => SuccessScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
