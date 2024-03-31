import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/product_detail_screen/product_detail_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../elements/custom_back_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text('congratulation'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: Center(
            child: Container(
          padding: EdgeInsets.all(15),
          height: Get.height * 0.6,
          width: Get.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
              color: AppColors.kPrimaryColor.withOpacity(0.4),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AppImages.appSplashBg),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.sH,
              Image.asset(
                AppImages.success,
                width: 150,
              ).animate().fade(curve: Curves.easeInQuad, duration: Duration(milliseconds: 900)),
              Spacer(),
              Text(
                'success'.tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              10.sH,
              Text(
                'thanksforOrderingfoodfromfoodsaver'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              Spacer(
                flex: 3,
              ),
              CustomButton(
                  text: 'backToOrder'.tr,
                  onTapped: () {
                    Get.back();
                    Get.back();
                    Get.off(() => ProductDetailScreen());
                  }),
              Spacer(),
            ],
          ),
        )),
      ),
    );
  }
}
