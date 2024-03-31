import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../utils/constant/app_colors.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Iconsax.star4,
              size: 80,
              color: AppColors.kPrimaryColor,
            )
                .animate(
                  autoPlay: true,
                )
                .scale(duration: Duration(milliseconds: 900)),
            20.sH,
             Text(
                textAlign: TextAlign.center,
                'ingredientDialogText'.tr),
            20.sH,
            CustomButton(
              text: 'gotIt'.tr,
              onTapped: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
