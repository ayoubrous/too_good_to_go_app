import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/controller/signup_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_loaders.dart';
import 'package:too_good_to_go_app/utils/constant/decider.dart';
import 'package:too_good_to_go_app/utils/constant/loaders.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/app_colors.dart';
import '../../../../utils/constant/image_string.dart';
import '../../../../utils/constant/sizes.dart';
import '../../../../utils/validators/validators.dart';
import '../../../elements/custom_button.dart';
import '../../../elements/custom_text_field.dart';
import '../../../elements/primary_header_appbar.dart';
import '../../../elements/privacy_dialog.dart';
import '../../../elements/term_of_services_dialog.dart';
import '../login_screen/widget/social_icons.dart';
import '../phone_login_screen/phone_login_screen.dart';
import '../select_role_screen/select_role_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  RxBool _isChecked = false.obs;

  @override
  Widget build(BuildContext context) {
    debugPrint(Decider.groupValue);
    final controller = Get.put(SignUpController());
    return Obx(
      () => CustomLoader(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                PrimaryHeaderAppBar(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      20.sH,
                      Text(
                        'createAccount'.tr,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.white),
                      ),
                      8.sH,
                      Text(
                        'signUpsubTitle'.tr,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                  child: Form(
                    key: controller.signUpKey,
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
                        15.sH,
                        CustomTextField(
                          validator: (v) => BValidators.validateEmptyText('Name', v),
                          controller: controller.name,
                          hintText: 'name'.tr,
                          isPrefixIcon: true,
                          prefixIcon: CupertinoIcons.person,
                        ),
                        CustomTextField(
                          controller: controller.email,
                          validator: (v) => BValidators.validateEmail(v),
                          hintText: 'email'.tr,
                          isPrefixIcon: true,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: CupertinoIcons.mail,
                        ),
                        CustomTextField(
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Phone Number is required';
                            }
                          },
                          controller: controller.phoneNumber,
                          hintText: 'phoneNumber'.tr,
                          isPrefixIcon: true,
                          textInputType: TextInputType.phone,
                          prefixIcon: Iconsax.mobile,
                        ),
                        CustomTextField(
                          controller: controller.password,
                          validator: (v) => BValidators.validatePassword(v),
                          hintText: 'password'.tr,
                          isPrefixIcon: true,
                          prefixIcon: Iconsax.password_check,
                          isPasswordField: true,
                          obsecureText: true,
                        ),
                        CustomTextField(
                          hintText: 'confirmPassword'.tr,
                          isPrefixIcon: true,
                          controller: controller.confirmPassword,
                          validator: (v) {
                            if (v != controller.password.text) {
                              return 'Confirm Password does not match!';
                            }
                          },
                          prefixIcon: Iconsax.password_check,
                          isPasswordField: true,
                          obsecureText: true,
                        ),
                        10.sH,
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                value: _isChecked.value,
                                onChanged: (bool? value) {
                                  _isChecked.value = value ?? false;
                                },
                                activeColor: AppColors.kPrimaryColor,
                              ),
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'Accept ', style: Theme.of(context).textTheme.bodySmall),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          showPrivacyPolicyDialog(context);
                                          //Get.to(() => PrivacyPolicyScreen());
                                        },
                                    ),
                                    TextSpan(text: ' and ', style: Theme.of(context).textTheme.bodySmall),
                                    TextSpan(
                                      text: 'Terms of Service',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          showTermOfServicesDialog(context);
                                          //Get.to(() => TermsOfServiceScreen());
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        25.sH,
                        CustomButton(
                          text: 'signup'.tr,
                          onTapped: () {
                            if (controller.signUpKey.currentState!.validate()) {
                              if (_isChecked.value) {
                                controller.signUp();
                              } else {
                                BLoaders.warningSnackBar(
                                    title: 'Warning',
                                    messagse: 'You must agree to the Privacy Policy and Terms of Service.');
                              }
                            }

                            // if (controller.signUpKey.currentState!.validate()) {
                            //   controller.signUp();
                            // }
                            // Get.offAll(() => AccessLocationScreen());
                          },
                        ),
                        15.sH,
                        Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'alreadyHaveAnAccount?'.tr, style: Theme.of(context).textTheme.bodySmall),
                                TextSpan(
                                    text: 'login'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.back();
                                      }),
                              ],
                            ),
                          ),
                        ),
                        20.sH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialIocns(
                              ontapped: () {
                                _handleSignIn();
                              },
                              widget: Image.asset(AppImages.google),
                            ),
                            SocialIocns(
                              ontapped: () {},
                              widget: Image.asset(AppImages.facebook),
                            ),
                            SocialIocns(
                              ontapped: () {
                                Get.to(() => PhoneLoginScreen());
                              },
                              widget: const Icon(
                                Icons.phone,
                                color: AppColors.kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: kToolbarHeight / 1.5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        await _storeUserData(user);
        Get.to(
          () => SelectRoleScreen(),
        );
      }
    } catch (error) {
      print("Error signing in with Google: $error");
    }
  }

  Future<void> _storeUserData(User? user) async {
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

        await usersCollection.doc(user.uid).set(userData);
      } catch (error) {
        print("Error storing user record: $error");
        // Handle error
      }
    }
  }
}
