import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';

import '../utils/constant/loaders.dart';

class BusinessRegistrationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getBusinessCategories();
    getBusinessField();
    //getAdminId();
  }

  final bName = TextEditingController();
  final bDescription = TextEditingController();
  final bLocation = TextEditingController();
  final bPhoneNumber = TextEditingController();
  var isLoading = false.obs;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  var isTapped = false.obs;
  String catName = "";
  String catID = "";
  var isCreated = false.obs;
  var isApproved = false.obs;
  var isBlocked = false.obs;
  var businessId = ''.obs;
  var businessName = ''.obs;
  var businessImage = ''.obs;
  var bCategory = ''.obs;
  var bCategoryId = ''.obs;

  final List allCategories = [].obs;

  // storage
  var imagePath = ''.obs;
  var imageLink = ''.obs;

  getBusinessCategories() {
    BackEndConfig.businessCategoriesCollection.snapshots().listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        // allCategories.clear();
        allCategories.add(element);
        // update();
      });
    });
  }

  pickImage({context, required ImageSource imageSource}) async {
    try {
      final Pickedimage = await ImagePicker().pickImage(source: imageSource, imageQuality: 70);
      if (Pickedimage == null) return;
      imagePath.value = Pickedimage.path;
    } on PlatformException catch (e) {
      BLoaders.errorSnackBar(title: 'error'.tr, messagse: e.toString());
    }
  }

  uploadBusinessImage() async {
    var fileName = basename(imagePath.value);
    var destination = 'business/$fileName)';

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagePath.value));
    imageLink.value = await ref.getDownloadURL();
  }

  Future<void> addBusiness({bool isCreated = false}) async {
    // isLoading(true);
    String bId = BackEndConfig.businessCollection.doc().id;
    await BackEndConfig.businessCollection.doc(bId).set({
      'bId': bId,
      'bOwnerName': FirebaseAuth.instance.currentUser!.displayName,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'bName': bName.text,
      'bDescription': bDescription.text,
      'bLocation': bLocation.text,
      'bPhoneNumber': bPhoneNumber.text,
      'bCategory': catName,
      'bCategoryId': catID,
      'bImage': imageLink.value,
      'isApproved': false,
      'isCreated': isCreated,
      'isBlocked': false,
    }).then((value) async {
      // isLoading(false);
      Get.back();
      await sendNotification('${bName.text.toString()} isCreatedTakeALook'.tr);
      BLoaders.successSnackBar(title: 'successfullyAdded'.tr, messagse: 'waitForApprovalFromAdmin'.tr);
    }).onError((error, stackTrace) {
      // isLoading(false);
      BLoaders.errorSnackBar(title: 'error'.tr, messagse: error.toString());
    });
  }

  getBusinessField() {
    BackEndConfig.businessCollection
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        isCreated.value = doc['isCreated'];
        isApproved.value = doc['isApproved'];
        isBlocked.value = doc['isBlocked'];
        businessId.value = doc['bId'];
        businessName.value = doc['bName'];
        businessImage.value = doc['bImage'];
        bCategory.value = doc['bCategory'];
        bCategoryId.value = doc['bCategoryId'];
        print(doc["bId"]);
      }
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

  // validation.
  bool validateBusiness() {
    if (imagePath.value == '' && bCategory.value == '') {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Please select image and category');
      return false;
    }
    if (bName.text.isEmpty) {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Business Name is Empty');
      return false;
    }
    if (bDescription.text.isEmpty) {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Business Description is Empty');
      return false;
    }
    if (bLocation.text.isEmpty) {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Business Location is Empty');
      return false;
    }
    if (bPhoneNumber.text.isEmpty) {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Business PhoneNumber is Empty');
      return false;
    }

    return true;
  }
}
