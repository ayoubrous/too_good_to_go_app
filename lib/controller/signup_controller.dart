import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/access_location_screen/access_location_screen.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/decider.dart';
import 'package:too_good_to_go_app/utils/constant/loaders.dart';

import '../presentation/view/authentication_view/select_role_screen/select_role_screen.dart';

class SignUpController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  final signUpKey = GlobalKey<FormState>();

  // text controllers
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phoneNumber = TextEditingController();

  // signUp Function
  Future<void> signUp() async {
    try {
      isLoading(true);
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value) {
        isLoading(false);
        BackEndConfig.userCollection.doc(auth.currentUser!.uid).set(
          {
            'uid': auth.currentUser!.uid,
            'name': name.text,
            'email': email.text,
            'password': password.text,
            'phoneNumber': phoneNumber.text,
            'image': '',
            'isBusiness': Decider.groupValue == 'Business Account' ? true : false,
            'isBlocked': false,
            'isDeactivated': false,
          },
        ).then((value) {
          BLoaders.successSnackBar(title: 'congratulation'.tr, messagse: 'yourAccountHasbeenCreated'.tr);
          Get.to(() => SelectRoleScreen());
          // Get.to(() => const AccessLocationScreen());
        });
      }).onError((error, stackTrace) {
        isLoading(false);
        BLoaders.errorSnackBar(title: 'error'.tr, messagse: error.toString());
      });
    } on FirebaseAuthException catch (e) {
      //BLoaders.errorSnackBar(title: e.message.toString());
    }
  }
}
