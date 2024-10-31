import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import 'package:image_picker/image_picker.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';

import '../utils/constant/loaders.dart';

class EditProductController extends GetxController {
  var isLoading = false.obs;
  final name = TextEditingController();
  final description = TextEditingController();
  final totalItem = TextEditingController();
  final actualPrice = TextEditingController();
  final disPrice = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();


  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  void pickStartTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      startTimeController.text = pickedTime.format(Get.context!);
    }
  }

  void pickEndTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      endTimeController.text = pickedTime.format(Get.context!);
    }
  }

  var imagePath = ''.obs;
  var imageLink = ''.obs;

  pickImage({context, required ImageSource imageSource}) async {
    try {
      final Pickedimage = await ImagePicker().pickImage(source: imageSource, imageQuality: 70);
      if (Pickedimage == null) return;
      imagePath.value = Pickedimage.path;
    } on PlatformException catch (e) {
      BLoaders.errorSnackBar(title: 'error'.tr, messagse: e.toString());
    }
  }

  uploadProductImage() async {
    var fileName = basename(imagePath.value);
    var destination = 'product/$fileName)';

    var ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagePath.value));
    imageLink.value = await ref.getDownloadURL();
  }

  updateProduct({pName, pDescription, pTotalItem, pActualPrice, pDisPrice, pStartTime, pEndTime, pImage,id}) async {
    isLoading(true);
    BackEndConfig.productCollection.doc(id).set({
      'pName': pName,
      'pDescription': pDescription,
      'pTotalItemLeft': pTotalItem,
      'pActualPrice': pActualPrice,
      'pDisPrice': pDisPrice,
      'pStartTime': pStartTime,
      'pEndTime': pEndTime,
      'pImage': pImage,

    }, SetOptions(merge: true)).then((value) {
      isLoading(false);
      Get.back();
      BLoaders.successSnackBar(
        title: 'updateSuccessfully'.tr,
      );
    });
  }
}
