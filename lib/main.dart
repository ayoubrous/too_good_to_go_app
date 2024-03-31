import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/controller/localization_controller.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import 'languages/languages.dart';
import 'presentation/view/authentication_view/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalizationController localeController = Get.put(LocalizationController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalizationController localeController = Get.find();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // 'com.google.gms:google-services:4.3.15' in project level build.gradle file
    return GetMaterialApp(
      title: 'Too Good To Go',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      translations: Languages(),
      // locale: Get.deviceLocale,
      locale: localeController.locale.value,
      fallbackLocale: Locale('en', 'US'),
      home: SplashScreen(),
    );
  }
}
