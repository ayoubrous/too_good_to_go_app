import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/primary_header_appbar.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/decider.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../access_location_screen/access_location_screen.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderAppBar(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.sH,
                  Text(
                    'selectAccountType'.tr,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      AppImages.appLogo,
                      width: 80,
                    ),
                  ),
                  15.sH,
                  Divider(),
                  30.sH,
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              Decider.groupValue = 'Customer Account';
                            });
                          },
                          child: Container(
                            height: Get.height * 0.3,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: AppColors.textFieldGreyColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                                border: const Border(bottom: BorderSide(color: AppColors.kPrimaryColor, width: 6))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Radio<String>(
                                      activeColor: AppColors.kPrimaryColor,
                                      value: 'Customer Account',
                                      groupValue: Decider.groupValue,
                                      onChanged: (v) {
                                        setState(() {
                                          Decider.groupValue = v!;
                                        });
                                      }),
                                ),
                                Image.asset(
                                  AppImages.customerAccount,
                                  width: 80,
                                ),
                                Text(
                                  'CustomerAccount'.tr,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      20.sW,
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              Decider.groupValue = 'Business Account';
                            });
                          },
                          child: Container(
                            height: Get.height * 0.3,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: AppColors.textFieldGreyColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                                border: const Border(bottom: BorderSide(color: AppColors.kPrimaryColor, width: 6))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Radio<String>(
                                      activeColor: AppColors.kPrimaryColor,
                                      value: 'Business Account',
                                      groupValue: Decider.groupValue,
                                      onChanged: (v) {
                                        setState(() {
                                          Decider.groupValue = v!;
                                        });
                                      }),
                                ),
                                Image.asset(
                                  AppImages.businessAccount,
                                  width: 80,
                                ),
                                Text(
                                  'BusinessAccount'.tr,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  40.sH,
                  CustomButton(
                    text: 'done'.tr,
                    onTapped: () {
                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'isBusiness': Decider.groupValue == 'Business Account' ? true : false,
                      }, SetOptions(merge: true)).then((value) {
                        Get.to(() => const AccessLocationScreen());
                      });

                      // Get.offAll(() => LoginScreen());
                    },
                  ),
                  8.sH,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
