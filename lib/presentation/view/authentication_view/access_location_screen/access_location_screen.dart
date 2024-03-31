import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/navigation_bar_view/navigation_bar_screen.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

class AccessLocationScreen extends StatelessWidget {
  const AccessLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('chooseLocation'.tr),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => NavigationBarScreen());
            },
            child: Text('skip'.tr),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: Column(
          children: [
            20.sH,
            Center(
              heightFactor: 2,
              child: Image.asset(
                AppImages.map,
                width: Get.width * 0.6,
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {},
              child: Text('useCurrentLocation'.tr),
            ),
            10.sH,
            CustomButton(text: 'pickLocation'.tr, onTapped: () {}),
          ],
        ),
      ),
    );
  }
}
