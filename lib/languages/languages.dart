import 'package:get/get.dart';
import 'package:too_good_to_go_app/languages/fr.dart';

import 'ar.dart';
import 'eng.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // english
        'en_US': eng,
        // arabic
        'ar_AE': arabic,
        'fr_FR': fr,
      };
}
