import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/get_started_screen/get_started_screen.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';

import '../../home_view/navigation_bar_view/navigation_bar_screen.dart';

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
              width: AppSizes.imageThumbSize * 1.2,
            ).animate().scale(
              duration: Duration(milliseconds: 1000),
            ),
          ],
        ),
      ),
    );
  }

  final _auth = FirebaseAuth.instance;

  screenRedirect() async {
    User? user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() =>  NavigationBarScreen());
    } else {
      Get.offAll(() => const GetStartedScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      screenRedirect();
    });
  }
}
