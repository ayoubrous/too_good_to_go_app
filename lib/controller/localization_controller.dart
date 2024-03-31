import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController {
  var locale = Rx<Locale?>(null);
  var isArabic = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLocale();
  }

  // Load locale from shared preferences
  void _loadLocale() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    if (languageCode != null) {
      var locale = Locale(languageCode);
      setLocale(locale);
    }
  }

  // Update and persist locale
  Future<void> setLocale(Locale newLocale) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', newLocale.languageCode);
    locale.value = newLocale;
    isArabic.value = newLocale.languageCode == 'ar';
    Get.updateLocale(newLocale);
  }
}
