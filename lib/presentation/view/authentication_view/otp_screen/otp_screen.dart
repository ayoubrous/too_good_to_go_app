import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:too_good_to_go_app/presentation/elements/primary_header_appbar.dart';
import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
import 'package:too_good_to_go_app/utils/constant/loaders.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/app_colors.dart';
import '../../../../utils/constant/decider.dart';
import '../../../../utils/constant/image_string.dart';
import '../../../elements/custom_button.dart';
import '../select_role_screen/select_role_screen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  Timer? _timer;
  int _countDown = 30;
  bool resend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countDown > 0) {
          _countDown--;
        } else {
          resend = true;
          _timer!.cancel();
        }
      });
    });
  }

  void reSendOTP() {
    if (resend) {
      setState(() {
        _countDown = 30;
        resend = false;
      });
      startTimer();
    }
  }

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
                    'verification'.tr,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.white),
                  ),
                  8.sH,
                  Text(
                    'verificationSubtitle'.tr,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
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
                  const Divider(),
                  25.sH,
                  Center(
                    child: Pinput(
                      controller: _otpController,
                      keyboardType: TextInputType.phone,
                      showCursor: true,
                      length: 6,
                      closeKeyboardWhenCompleted: true,
                      defaultPinTheme: PinTheme(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                              border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.3))),
                          textStyle: Theme.of(context).textTheme.titleMedium),
                    ),
                  ),
                  40.sH,
                  CustomButton(
                    text: 'verify'.tr,
                    onTapped: () async {
                      String otp = _otpController.text.trim();
                      if (otp.isNotEmpty) {
                        makeLoadingTrue();
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otp);
                          UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
                          await saveUserRecord(authResult.user!).then((value) {
                            Get.to(() => const SelectRoleScreen());
                          });
                          // Get.offAll(() => NavigationBarScreen());
                          print('==User signed in successfully==');
                        } catch (e) {
                          makeLoadingFalse();
                          print('Error verifying OTP: $e');
                          BLoaders.errorSnackBar(title: 'error'.tr, messagse: 'failedtoverifyOTPPleasetryagain'.tr);
                        }
                        makeLoadingFalse();
                      } else {
                        BLoaders.warningSnackBar(title: 'warning'.tr, messagse: 'pleaseentertheOTP'.tr);
                      }
                    },
                  ),
                  // 30.sH,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "00 : ${_countDown.toString()}",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "Didn't receive otp:\t",
                  //           style: Theme.of(context).textTheme.bodyLarge,
                  //         ),
                  //         InkWell(
                  //           onTap: () {
                  //             reSendOTP();
                  //           },
                  //           child: Text(
                  //             "Resend",
                  //             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  //                   fontWeight: FontWeight.bold,
                  //                   color: resend ? AppColors.kPrimaryColor : AppColors.greyColor,
                  //                 ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isLoading = false;

  makeLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  makeLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> saveUserRecord(User? user) async {
    if (user != null) {
      try {
        final Map<String, dynamic> userData = {
          'uid': user.uid,
          'name': user.displayName,
          'email': user.email,
          'password': '',
          'phoneNumber': user.phoneNumber,
          'image': '',
          'isBusiness': Decider.groupValue == 'Business Account' ? true : false,
          'isBlocked': false,
          'isDeactivated': false,
        };

        // Store user data in Firestore
        await FirebaseFirestore.instance.collection(BackEndConfig.kUserCollection).doc(user.uid).set(userData);
      } catch (error) {
        print("Error storing user record: $error");
        // Handle error
      }
    }
  }
}
