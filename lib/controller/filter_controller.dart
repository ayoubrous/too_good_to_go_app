import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';

class FilterController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchBusinessCategory();
    fetchMenu();
    fetchProductPrice();
    filter(menuID: '', businessCatId: '', maxPrice: '', minPrice: '', selectedendTime: '', selectedstartTime: '');
  }

  select(index, value) {
    value = index;
  }

  // Business category
  final businessCatList = [].obs;
  var selectedBusinessCatId = RxString('');

  fetchBusinessCategory() {
    BackEndConfig.businessCategoriesCollection.snapshots().listen((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        update();
        businessCatList.add(element);
      }
    });
  }

  // Menu list
  final menList = [].obs;
  var selectedMenuId = RxString('');

  fetchMenu() {
    BackEndConfig.menuCollection.snapshots().listen((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        menList.add(element);
      }
    });
  }

  // filter function..
  final filterProduct = [].obs;

  // var businessId = ''.obs;
  //var menuId = ''.obs;

  var intialPrice = RxDouble(0);
  var productPrice = RxDouble(0);

  fetchProductPrice() {
    BackEndConfig.productCollection.snapshots().listen((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        update();
        productPrice.value = double.parse(element['pDisPrice']);
      }
    });
  }

  filter(
      {required menuID,
      required businessCatId,
      required minPrice,
      required maxPrice,
      required selectedendTime,
      required selectedstartTime}) {
    print("food type $menuID");
    print("business type $businessCatId");
    print("min dtype $minPrice");
    print("max type $maxPrice");
    print(selectedstartTime);
    print(selectedendTime);
    BackEndConfig.productCollection
        .where('pBusinessCategoryId', isEqualTo: businessCatId)
        .where('foodTypeId', isEqualTo: menuID)
        .where('pDisPrice', isGreaterThanOrEqualTo: minPrice)
        .where('pDisPrice', isLessThanOrEqualTo: maxPrice)
        .where('pStartTime', isGreaterThanOrEqualTo: selectedstartTime)
        .where('pEndTime', isLessThanOrEqualTo: selectedendTime)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      filterProduct.clear();
      update();
      for (var element in querySnapshot.docs) {
        // menuId.value = element['foodTypeId'];
        // businessId.value = element['pBusinessId'];
        filterProduct.add(element);
        update();
      }
    });
  }
}
