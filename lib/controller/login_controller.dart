import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:too_good_to_go_app/utils/constant/loaders.dart';

import '../presentation/view/home_view/navigation_bar_view/navigation_bar_screen.dart';
import '../utils/constant/back_end_config.dart';
import '../utils/exceptions/firebaseauth_exception.dart';
import 'location_controller.dart';

class LoginController extends GetxController {
  final locationController = Get.put(LocationController());
  var isLoading = false.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final loginKey = GlobalKey<FormState>();

  // text controller
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read('REMEMBER-ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER-ME_PASSWORD') ?? '';
    rememberMe.value = localStorage.read('REMEMBER-ME') ?? false;
    getUserAccountStatus();
    // email.text = storedEmail;
    // password.text = storedPassword;
  }

  // functions
  Future<void> login() async {
    try {
      isLoading(true);
      if (rememberMe.value) {
        localStorage.write('REMEMBER-ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER-ME_PASSWORD', password.text.trim());
      }
      await _auth.signInWithEmailAndPassword(email: email.text, password: password.text).then((value) {
        isLoading(false);
        Get.offAll(
          () => NavigationBarScreen(),
        );
        locationController.getLocation();

        BLoaders.successSnackBar(title: 'loginSuccessfully'.tr, messagse: value.user!.email.toString());
      }).onError((error, stackTrace) {
        isLoading(false);
        BLoaders.errorSnackBar(title: 'error'.tr, messagse: error.toString());
      });
    } on FirebaseAuthException catch (e) {
      throw BFirebaseAuthException(e.code).message;
      BLoaders.errorSnackBar(title: e.code.toString());
    }
  }

  Future<void> sendEmailResetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.back();
    } on FirebaseAuthException catch (e) {
      BLoaders.errorSnackBar(title: e.message.toString());
    } on FirebaseException catch (e) {
      BLoaders.errorSnackBar(title: e.message.toString());
    } catch (e) {
      BLoaders.errorSnackBar(title: e.toString());
    }
  }

  var isDeactivated = false.obs;

  void getUserAccountStatus() {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      BackEndConfig.userCollection.doc(currentUser.uid).snapshots().listen((DocumentSnapshot snapshot) {
        isDeactivated.value = snapshot.get('isDeactivated');
      });
    }
  }

}
