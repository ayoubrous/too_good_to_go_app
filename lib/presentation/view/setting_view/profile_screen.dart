import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/controller/login_controller.dart';
import 'package:too_good_to_go_app/controller/profile_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/icon_button.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/login_screen/login_screen.dart';
import 'package:too_good_to_go_app/presentation/view/setting_view/business_registration/business_registration.dart';
import 'package:too_good_to_go_app/presentation/view/setting_view/contact_us_screen/contact_us_screen.dart';
import 'package:too_good_to_go_app/presentation/view/setting_view/languages_screen/language_screen.dart';
import 'package:too_good_to_go_app/presentation/view/setting_view/order_screen/order_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/image_string.dart';
import 'favorite_screen/favoite_screen.dart';
import 'my_listing_screen/my_listing_screen.dart';
import 'personal_info_screen/personal_info_screen.dart';
import 'setting_screen/widget/setting_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    // final authController = Get.put(AuthController());
    final profileController = Get.put(ProfileController());
    final loginCOntroller = Get.put(LoginController());
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(isBusiness ? 'businessProfile'.tr : 'clientProfile'.tr)
          ,
        ),
        body: profileController.isBlocked.value
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You are blocked due to some reason',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: kToolbarHeight),
                      const Icon(
                        Icons.block,
                        color: AppColors.kPrimaryColor,
                        size: AppSizes.iconLg,
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      20.sH,
                      Row(
                        children: [
                          userProfileImage != ''
                              ? PhysicalModel(
                                  elevation: 8,
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.textFieldGreyColor,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 55,
                                      height: 55,
                                      imageUrl: userProfileImage.toString(),
                                      placeholder: (context, url) => Container(
                                        width: 55,
                                        height: 55,
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
                          10.sW,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name ?? 'Name',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  email ?? 'user@gmail.com',
                                  // maxLines: 1,
                                  softWrap: true,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          // Spacer(),
                          CustomIconButton(
                            onTapp: () {
                              Get.to(
                                () => PersonalInfoScreen(),
                              );
                            },
                            iconData: Iconsax.edit,
                            iconColor: AppColors.kPrimaryColor,
                          ),
                        ],
                      ),
                      8.sH,
                      const Divider(),
                      8.sH,
                      isBusiness
                          ? Column(
                              children: [
                                SettingTile(
                                    title: 'businessRegistration'.tr,
                                    onTap: () {
                                      Get.to(() => BusinessRegistrationScreen());
                                    },
                                    icon: Icons.business_center_outlined),
                                SettingTile(
                                    title: 'myListing'.tr,
                                    onTap: () {
                                      Get.to(() => MyListingScreen());
                                    },
                                    icon: Iconsax.note),
                                SettingTile(
                                    title: 'myOrders'.tr,
                                    onTap: () {
                                      Get.to(() => OrderScreen());
                                    },
                                    icon: CupertinoIcons.car),
                                SettingTile(
                                  title: 'notification'.tr,
                                  onTap: () {},
                                  icon: CupertinoIcons.bell,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SettingTile(
                                    title: 'Personal Info'.tr,
                                    onTap: () {
                                      Get.to(() => PersonalInfoScreen());
                                    },
                                    icon: CupertinoIcons.person),
                                SettingTile(
                                    title: 'myOrders'.tr,
                                    onTap: () {
                                      Get.to(() => OrderScreen());
                                    },
                                    icon: CupertinoIcons.car),
                                SettingTile(
                                  title: 'Notification',
                                  onTap: () {},
                                  icon: CupertinoIcons.bell,
                                ),
                              ],
                            ),
                      // SettingTile(
                      //     title: 'favourite'.tr,
                      //     onTap: () {
                      //       Get.to(() => const FavoriteScreen());
                      //     },
                      //     icon: CupertinoIcons.heart),
                      // SettingTile(
                      //     title: 'myOrders'.tr,
                      //     onTap: () {
                      //       Get.to(() => OrderScreen());
                      //     },
                      //     icon: CupertinoIcons.car),
                      // SettingTile(
                      //     title: 'languages'.tr,
                      //     onTap: () {
                      //       Get.to(() => const LanguageScreen());
                      //     },
                      //     icon: Icons.language),
                      // SettingTile(
                      //     title: 'contactus'.tr,
                      //     onTap: () {
                      //       Get.to(() => ContactUsScreen());
                      //     },
                      //     icon: Icons.contact_mail_outlined),
                      // SettingTile(
                      //     title: 'Logout'.tr,
                      //     onTap: () async {
                      //       GoogleSignIn googleSignIn = GoogleSignIn();
                      //       await googleSignIn.signOut().then((value) {
                      //         Get.offAll(() => LoginScreen());
                      //       });
                      //       FirebaseAuth.instance.signOut().then((value) {
                      //         Get.offAll(() => LoginScreen());
                      //       });
                      //     },
                      //     icon: Iconsax.logout),
                      const SizedBox(height: kToolbarHeight * 1.2),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  String? email;
  String? name;
  String? userProfileImage;
  bool isBusiness = false;

  getCurrentUser() {
    FirebaseFirestore.instance
        .collection(BackEndConfig.kUserCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      setState(() {});
      name = documentSnapshot.get('name');
      email = documentSnapshot.get('email');
      userProfileImage = documentSnapshot.get('image');
      isBusiness = documentSnapshot.get('isBusiness');
    });
  }
}
