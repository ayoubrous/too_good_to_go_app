// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:too_good_to_go_app/utils/constant/loaders.dart';
//
// import '../presentation/view/home_view/navigation_bar_view/navigation_bar_screen.dart';
//
// class LocationController extends GetxController {
//   var address = ''.obs;
//   var coordinates = ''.obs;
//   final box = GetStorage();
//
//   // checkPermission() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     await Geolocator.openLocationSettings();
//   //     return;
//   //   }
//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       BLoaders.warningSnackBar(title: 'Request Denied');
//   //
//   //       return;
//   //     }
//   //   }
//   //
//   //   if (permission == LocationPermission.deniedForever) {
//   //     BLoaders.warningSnackBar(title: 'Denied Forever!');
//   //     return;
//   //   }
//   //   getLocation();
//   // }
//   //
//   getLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       coordinates.value = 'Latitude : ${position.latitude} \nLongitude :${position.longitude}';
//       List<Placemark> result = await placemarkFromCoordinates(position.latitude, position.longitude);
//       if (result.isNotEmpty) {
//         address.value = '${result[0].locality},${result[0].administrativeArea}' as String;
//         final box = GetStorage();
//         box.write('savedAddress', address.value);
//         box.write('savedCoordinates', coordinates);
//         Future.delayed(Duration(seconds: 1));
//         Get.to(
//           () => NavigationBarScreen(),
//         );
//         // Get.to(() => HomeScreen(
//         //       address: address,
//         //     ));
//       }
//       print(position);
//     } catch (e) {
//       BLoaders.errorSnackBar(title: 'error'.tr, messagse: e.toString());
//     }
//   }
//
//   checkPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // If location services are disabled, prompt the user to open location settings
//       await Geolocator.openLocationSettings();
//       return;
//     }
//
//     // Check current location permission status
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       // If location permission is denied, request permission from the user
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // If the user denies the request, display a warning message
//         BLoaders.warningSnackBar(title: 'Location Permission Denied');
//         return;
//       }
//     }
//
//     // If location permission is permanently denied, inform the user
//     if (permission == LocationPermission.deniedForever) {
//       BLoaders.warningSnackBar(title: 'Location Permission Denied Forever');
//       return;
//     }
//
//     // If location permissions are granted, proceed to get the current location
//     getLocation();
//   }
//
//   loadSavedLocation() {
//     address.value = box.read('savedAddress') ?? '';
//     coordinates.value = box.read('savedCoordinates') ?? '';
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadSavedLocation();
//   }
// }
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:too_good_to_go_app/utils/constant/loaders.dart';

import '../presentation/view/home_view/navigation_bar_view/navigation_bar_screen.dart';

class LocationController extends GetxController {
  var address = ''.obs;
  var coordinates = ''.obs;
  final box = GetStorage(); // Declare GetStorage instance at the class level

  @override
  void onInit() {
    super.onInit();
    loadSavedLocation();
  }

  // Check and request location permission
  checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        BLoaders.warningSnackBar(title: 'Location Permission Denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      BLoaders.warningSnackBar(title: 'Location Permission Denied Forever');
      return;
    }

    getLocation();
  }

  // Get current location
  getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      coordinates.value = 'Latitude : ${position.latitude} \nLongitude : ${position.longitude}';
      List<Placemark> result = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (result.isNotEmpty) {
        address.value = '${result[0].locality}, ${result[0].administrativeArea}';

        // Save location data in GetStorage
        box.write('savedAddress', address.value);
        box.write('savedCoordinates', coordinates.value);

        // Navigate to the next screen after a delay
        Future.delayed(Duration(seconds: 1));
        Get.to(() => NavigationBarScreen());
      }
    } catch (e) {
      BLoaders.errorSnackBar(title: 'Error', messagse: e.toString());
    }
  }

  // Load saved location data
  loadSavedLocation() {
    address.value = box.read('savedAddress') ?? '';
    coordinates.value = box.read('savedCoordinates') ?? '';
  }

  // Method to clear location data on logout
  clearLocationData() {
    box.remove('savedAddress');
    box.remove('savedCoordinates');
  }
}
