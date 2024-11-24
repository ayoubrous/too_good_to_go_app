import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../utils/constant/back_end_config.dart';
import '../utils/constant/loaders.dart';

class ProductController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getMenu();
    // getProductName();
  }

  late dynamic productSnapshot;
  var isLoading = false.obs;
  var isFav = false.obs;
  var searchedController = TextEditingController();
  final pName = TextEditingController();
  final pDescription = TextEditingController();
  final pTotalItemLeft = TextEditingController();
  final pActualPrice = TextEditingController();
  final pDisPrice = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  final productKey = GlobalKey<FormState>();
  var item = 0.obs;
  var totalPrice = 0.obs;
  var cartTotalPrice = 0.obs;

  incrementQuantity(totalQuantity) {
    if (item < totalQuantity) item.value++;
  }

  decrementQuantity() {
    if (item > 0) item.obs.value--;
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * item.value;
  }

  void pickStartTime() async {
    TimeOfDay? pickedTime = await showTimePicker(context: Get.context!, initialTime: TimeOfDay.now());

    if (pickedTime != null) {
      startTimeController.text = pickedTime.format(Get.context!);
      // String time=pickedTime.
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
  final List menuList = [].obs;

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

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagePath.value));
    imageLink.value = await ref.getDownloadURL();
  }

  // function
  Future<void> addProduct(
      {pBusinessId,
      foodTypeName,
      foodTypeId,
      pBusinessName,
      pBusinessImage,
      businessCatName,
      businessCatId,
      startTime,
      endTime}) async {
    // isLoading(true);
    String pId = BackEndConfig.productCollection.doc().id;
    await BackEndConfig.productCollection.doc(pId).set({
      'pName': pName.text.toString(),
      'pImage': imageLink.value,
      'pDescription': pDescription.text.toString(),
      'pTotalItemLeft': pTotalItemLeft.text.toString(),
      'pActualPrice': pActualPrice.text.toString(),
      'pDisPrice': pDisPrice.text.toString(),
      'pStartTime': startTime.toString(),
      'pEndTime': endTime.toString(),
      'pId': pId,
      'pBusinessId': pBusinessId,
      'foodType': foodTypeName,
      'foodTypeId': foodTypeId,
      'pBusinessName': pBusinessName,
      'pBusinessCategoryName': businessCatName,
      'pBusinessCategoryId': businessCatId,
      'pBusinessImage': pBusinessImage,
      "p_Whishlist": FieldValue.arrayUnion([]),
      'rating': 2.0,
      'createdAt': DateTime.now(),
    }).then((value) {
      // isLoading(false);
      Get.back();
      clearAllFields();
      BLoaders.successSnackBar(title: 'successfullyAdded'.tr, messagse: 'productAdded'.tr);
    }).onError((error, stackTrace) {
      // isLoading(false);
      BLoaders.errorSnackBar(title: 'error'.tr, messagse: error.toString());
      print(error.toString());
    });
  }

  var menuName = ''.obs;

  getMenu() {
    BackEndConfig.menuCollection.get().then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        //menuList.clear();
        // update();
        menuName.value = element['name'];
        menuList.add(element);
        //update();
      }
    });
  }

  var selectedIndex = 0.obs;

  select(index) {
    selectedIndex.value = index;
  }

  var productName = ''.obs;

  searchProduct(title) {
    return BackEndConfig.productCollection.snapshots();
  }

  addToFavourite(docId, context) async {
    await BackEndConfig.productCollection.doc(docId).set(
        {
          'p_Whishlist': FieldValue.arrayUnion([currentUser!.uid]),
        },
        SetOptions(
          merge: true,
        ));
    isFav(true);
  }

  removeFavourite(docId, context) async {
    await BackEndConfig.productCollection.doc(docId).set(
        {
          'p_Whishlist': FieldValue.arrayRemove([currentUser!.uid]),
        },
        SetOptions(
          merge: true,
        ));
    isFav(false);
  }

  checkIsFav(data) async {
    if (data['p_Whishlist'].contains(currentUser!.uid)) {
      return true;
    } else {
      return false;
    }
  }

  clearAllFields() {
    pName.clear();
    pDescription.clear();
    pActualPrice.clear();
    pDisPrice.clear();
    imageLink = ''.obs;
    imagePath = ''.obs;
    startTimeController.clear();
    endTimeController.clear();
    pTotalItemLeft.clear();
    update();
  }

  clearAfterAddToCart() {
    item.value = 0;
    totalPrice.value = 0;
    update();
  }

  bool validateProduct(TimeOfDay? startTime, TimeOfDay? endTime) {
    if (imagePath.value == '') {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Please Select Image');
      return false;
    }
    if (pName.text.isEmpty) {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Product Name is Empty');
      return false;
    }
    if (pDescription.text.isEmpty) {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Product Description is Empty');
      return false;
    }
    if (pTotalItemLeft.text.isEmpty) {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Please Enter Total Item');
      return false;
    }
    if (pActualPrice.text.isEmpty || pActualPrice.text == '') {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Actual Price is empty');
      return false;
    }
    if (pDisPrice.text.isEmpty || pDisPrice.text == '') {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Dis Price is empty');
      return false;
    }

    if (startTime == null) {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Please select the Start Time');
      return false;
    }
    if (endTime == null) {
      BLoaders.warningSnackBar(title: 'Warning', messagse: 'Please select the End Time');
      return false;
    }
    // if (startTimeController.text.isEmpty) {
    //   BLoaders.warningSnackBar(title: 'Warning', messagse: 'Please select the Start Time');
    //   return false;
    // }
    // if (endTimeController.text.isEmpty) {
    //   BLoaders.warningSnackBar(title: 'Warning', messagse: 'Please select the End Time');
    //   return false;
    // }

    return true;
  }

  /// for calculating all cart price at once
  calculate(data) {
    cartTotalPrice.value = 0;
    for (var i = 0; i < data.length; i++) {
      cartTotalPrice.value = cartTotalPrice.value + int.parse(data[i]['totalPrice'].toString());
    }
  }

  /// for order purpose to show multiple item
  // List<dynamic> allcartItemList = [];
  List<Map<String, dynamic>> allcartItemList = [];
  allCartItem(data) {
    // allcartItemList.clear();

    for (var i = 0; i < data.length; i++) {
      FirebaseFirestore.instance.collection('cart').get().then((QuerySnapshot querySnapshot) {
        for (var element in querySnapshot.docs) {
          allcartItemList.add(element.data() as Map<String, dynamic>);
          update();
          print(querySnapshot.docs.length);
        }
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      FirebaseFirestore.instance.collection('cart').doc(productSnapshot[i].id).delete();
    }
  }
}
