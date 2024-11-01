import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:too_good_to_go_app/controller/auth_controller.dart';
import 'package:too_good_to_go_app/controller/localization_controller.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/exceptions/notification_permission.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import 'firebase_options.dart';
import 'languages/languages.dart';
import 'presentation/view/authentication_view/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    return Get.put(AuthController());
  });
  await NotificationPermision().requestPermission();
  Stripe.publishableKey =
  'pk_test_51O2bQ9HNCdxitP0OX8PiuBGdUIDj2OZlQtAdsViuviCJXFlr3MKdm8sbn3y1YKJ9BkoM9T9u0iS1YFYQtBCDV7yO00KQOUVsdK';

  await GetStorage.init();
  final LocalizationController localeController = Get.put(LocalizationController());
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(oneSignalAppId);
  OneSignal.Notifications.addClickListener((OSNotificationClickEvent event) {
    if (event.notification.additionalData!["custom_data"]["NOTIFICATION_TYPE"] == "MESSAGE_NOTIFICATION") {} else {}
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      locale: Get.deviceLocale,
      //locale: localeController.locale.value,
      fallbackLocale: Locale('en', 'US'),
      home: SplashScreen(),
    );
  }
}
