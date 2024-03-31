import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/get_started_screen/get_started_screen.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppImages.appSplashBg),
            Image.asset(
              AppImages.appLogo,
              width: AppSizes.imageThumbSize * 1.5,
            ).animate().scale(
                  duration: Duration(milliseconds: 900),
                ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      Get.to(() => GetStartedScreen());
    });
  }
}
