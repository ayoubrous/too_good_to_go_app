import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../presentation/view/authentication_view/login_screen/login_screen.dart';
import '../presentation/view/home_view/navigation_bar_view/navigation_bar_screen.dart';
import '../utils/constant/back_end_config.dart';
import '../utils/constant/loaders.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  var address = ''.obs;
  var coordinates = '';

  @override
  void onInit() {
    super.onInit();
    // checkPermission();
    //getUserDetail();
  }

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //var isBlocked = false.obs;

  screenRedirect() async {
    User? user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => NavigationBarScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      coordinates = 'Latitude : ${position.latitude} \nLongitude :${position.longitude}';
      List<Placemark> result = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (result.isNotEmpty) {
        address.value = '${result[0].locality},${result[0].administrativeArea}' as String;
        final box = GetStorage();
        box.write('savedAddress', address.value);
        box.write('savedCoordinates', coordinates);
        Future.delayed(Duration(seconds: 1));
        Get.to(
          () => NavigationBarScreen(),
        );
        // Get.to(() => HomeScreen(
        //       address: address,
        //     ));
      }
      print(position);
    } catch (e) {
      BLoaders.errorSnackBar(title: 'error'.tr, messagse: e.toString());
    }
  }

  checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If location services are disabled, prompt the user to open location settings
      await Geolocator.openLocationSettings();
      return;
    }

    // Check current location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // If location permission is denied, request permission from the user
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // If the user denies the request, display a warning message
        BLoaders.warningSnackBar(title: 'Location Permission Denied');
        return;
      }
    }

    // If location permission is permanently denied, inform the user
    if (permission == LocationPermission.deniedForever) {
      BLoaders.warningSnackBar(title: 'Location Permission Denied Forever');
      return;
    }

    // If location permissions are granted, proceed to get the current location
    getLocation();
  }

  loadSavedLocation() {
    final box = GetStorage();
    address.value = box.read('savedAddress') ?? '';
    coordinates = box.read('savedCoordinates') ?? '';
  }

// getUserDetail() {
//   BackEndConfig.userCollection
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .snapshots()
//       .listen((DocumentSnapshot documentSnapshot) {
//     update();
//     isBlocked.value = documentSnapshot.get('isBlocked');
//   });
// }
}
