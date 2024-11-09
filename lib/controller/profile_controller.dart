import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/loaders.dart';
import 'package:http/http.dart' as http;

import '../presentation/view/authentication_view/login_screen/login_screen.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    getUserAccountType();
    getUserDetail();
  }

  var isBusiness;

  getUserAccountType() async {
    var n = await BackEndConfig.userCollection.where('uid', isEqualTo: auth.currentUser!.uid).get().then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['isBusiness'];
      }
    });
    isBusiness = n;
  }

  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var imagePath = ''.obs;

  var imageLink = ''.obs;

  var isLoading = false.obs;

  /// function
  pickImage({context, required ImageSource imageSource}) async {
    try {
      final Pickedimage = await ImagePicker().pickImage(source: imageSource, imageQuality: 70);
      if (Pickedimage == null) return;
      imagePath.value = Pickedimage.path;
    } on PlatformException catch (e) {
      BLoaders.errorSnackBar(title: 'error'.tr, messagse: e.toString());
    }
  }

  uploadProfileImage() async {
    var fileName = basename(imagePath.value);
    var destination = 'users/${auth.currentUser!.uid}/$fileName)';

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagePath.value));
    imageLink.value = await ref.getDownloadURL();
  }

  /// for update do in the set merge (true)..
  updateProfile({name, phoneNumber, imgUrl}) async {
    isLoading(true);
    var store = BackEndConfig.userCollection.doc(auth.currentUser!.uid);
    await store.set({
      'name': name,
      'phoneNumber': phoneNumber,
      'image': imgUrl,
    }, SetOptions(merge: true)).then((value) {
      isLoading(false);

      Get.back();
      BLoaders.successSnackBar(title: 'success'.tr, messagse: 'profileAdded'.tr);
    });
    isLoading(false);
  }

  var username = ''.obs;
  var isBlocked = false.obs;
  getUserDetail() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      username.value = documentSnapshot.get('name');
      isBlocked.value = documentSnapshot.get('isBlocked');
    });
  }

  deactivateAccount() {
    FirebaseFirestore.instance
        .collection(BackEndConfig.kUserCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
      {
        'isDeactivated': true,
      },
      SetOptions(merge: true),
    ).then((value) async {
      Get.offAll(() => LoginScreen());
      await sendNotification('${username} De-Activate his Account');
    });
  }

  /// NOTIFICATION FUNCTION
  Future<void> sendNotification(String content) async {
    await getAdminId();

    var headers = {
      'Authorization': 'Bearer MzFmZTM5NWEtM2NjYS00NzA3LTg0OTctOGJmZjg2YjdiYzRl',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('https://onesignal.com/api/v1/notifications'));
    request.body = json.encode({
      "app_id": "44629f39-068c-42ad-9d70-95c4954f4c96",
      "include_player_ids": [adminPlayerID.value],
      // "include_player_ids": ["ade0858e-5c24-4115-950c-464526346bc4"],
      "contents": {"en": content}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('======== NOTIFICATION SEND ==========');
    } else {
      print(response.reasonPhrase);
    }
  }

  var adminPlayerID = ''.obs;

  Future<void> getAdminId() async {
    await FirebaseFirestore.instance
        .collection('tokens')
        .doc('TMGjRKn3NOdNG587hFcDtM47TxH2')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      update();
      adminPlayerID.value = documentSnapshot.get('id');
    });
  }
}
