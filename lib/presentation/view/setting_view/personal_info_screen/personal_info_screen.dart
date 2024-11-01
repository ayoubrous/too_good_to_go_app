import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/controller/profile_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_back_button.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/login_screen/login_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/back_end_config.dart';
import '../../../../utils/constant/image_string.dart';
import '../../../elements/icon_button.dart';
import '../../../elements/image_builder_widget.dart';
import '../edit_profile_screen/edit_profile_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  String? name;
  String? email;
  bool isDeactvated = false;
  String? phoneNumber;
  String? userProfileImage;

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Get.to(
                () => EditProfileScreen(
                  phoneNumber: phoneNumber.toString(),
                  name: name.toString(),
                  image: userProfileImage.toString(),
                ),
              );
            },
            child: Text('edit'.tr),
          ),
        ],
        leading: const CustomBackButton(),
        title: Text('profile'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            children: [
              20.sH,
              userProfileImage != ''
                  ? PhysicalModel(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.textFieldGreyColor,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                          imageUrl: userProfileImage.toString(),
                          placeholder: (context, url) => Container(
                            width: 60,
                            height: 60,
                            color: AppColors.textFieldGreyColor, // Placeholder background color
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.kPrimaryColor, // Loader color
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    )
                  : const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(AppImages.userPlaceHolder),
                    ),
              15.sH,
              Card(
                color: AppColors.textFieldGreyColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      _buildListTile('fullName'.tr, name ?? 'User', Iconsax.user),
                      _buildListTile('email'.tr, email ?? 'user@gmail.com', Icons.mail_outline),
                      _buildListTile('phone'.tr, phoneNumber ?? '1234566789', Icons.phone_enabled_outlined),
                    ],
                  ),
                ),
              ),
              15.sH,
              SizedBox(
                height: 58,
                width: double.infinity,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.kPrimaryColor),
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                  ),
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColor,
                                      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                                  child: Column(
                                    children: [
                                      20.sH,
                                      Text(
                                        'areYouSure'.tr,
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                      ),
                                      10.sH,
                                      Text(
                                        'deactivateAccountDialogText'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: AppColors.white),
                                      ),
                                      15.sH,
                                    ],
                                  ),
                                ),
                                10.sH,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('cancel'.tr)),
                                    TextButton(
                                      onPressed: () {
                                        profileController.deactivateAccount();
                                        // FirebaseFirestore.instance
                                        //     .collection(BackEndConfig.kUserCollection)
                                        //     .doc(FirebaseAuth.instance.currentUser!.uid)
                                        //     .set(
                                        //   {
                                        //     'isDeactivated': true,
                                        //   },
                                        //   SetOptions(merge: true),
                                        // ).then((value) async {
                                        //   Get.offAll(() => LoginScreen());
                                        //   await sendNotification('${name} De-Activate his Account');
                                        // });
                                      },
                                      child: Text('ok'.tr),
                                    ),
                                  ],
                                ),
                                10.sH,
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'deactivateAccount'.tr,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.kPrimaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getCurrentUser() {
    FirebaseFirestore.instance
        .collection(BackEndConfig.kUserCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      // setState(() {});
      name = snapshot.get('name');
      email = snapshot.get('email');
      isDeactvated = snapshot.get('isDeactivated');
      phoneNumber = snapshot.get('phoneNumber');
      userProfileImage = snapshot.get('image');
      setState(() {});
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
      setState(() {});
      adminPlayerID.value = documentSnapshot.get('id');
    });
  }

  ListTile _buildListTile(title, subtitle, icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CustomIconButton(
        iconData: icon,
        iconColor: AppColors.kPrimaryColor,
        circleColor: AppColors.white,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
