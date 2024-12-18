import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/image_string.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text('chooseLocatinToSeeWhatAvailable'.tr, textAlign: TextAlign.center),
      ),
      body: Column(
        children: [
          20.sH,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
            child: CustomTextField(
              hintText: 'searchForACity'.tr,
              isPrefixIcon: true,
              prefixIcon: Iconsax.map,
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                width: Get.width,
                color: AppColors.textFieldGreyColor,
                child: Image.asset(AppImages.appSplashBg),
              )),
          Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    15.sH,
                    Text(
                      'selectDistance'.tr,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: 0,
                      onChanged: (v) {},
                      activeColor: AppColors.kPrimaryColor,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Iconsax.location,
                        size: AppSizes.iconMd,
                      ),
                      label: Text('useCurrentLocation'.tr),
                    ),
                    CustomButton(
                        text: 'apply'.tr,
                        onTapped: () {
                          Get.back();
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
// /// open_street_map_search_and_pick
// import 'package:flutter/material.dart';
// import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
// import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   String locationAddress = 'sf';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: OpenStreetMapSearchAndPick(
//             baseUri: 'https://tile.thunderforest.com/cycle/{z}/{x}/{y}.png?apikey=0abb3e6ee9b946dd972323106b248442',
//             buttonColor: AppColors.kPrimaryColor,
//             buttonText: 'Set Current Location',
//             onPicked: (pickedData) {
//               setState(() {
//                 //print(pickedData.latLong.toString());
//
//                 locationAddress = pickedData.address.toString();
//               });
//             }),
//       ),
//     );
//   }
// }
