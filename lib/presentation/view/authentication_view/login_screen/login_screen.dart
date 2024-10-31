import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/controller/login_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_loaders.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/presentation/elements/primary_header_appbar.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/forgot_password_screen/forgot_password_screen.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/phone_login_screen/phone_login_screen.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/select_role_screen/select_role_screen.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/signup_screen/signup_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';
import 'package:too_good_to_go_app/utils/validators/validators.dart';

import '../../../../utils/constant/decider.dart';
import '../../../../utils/constant/image_string.dart';
import 'widget/social_icons.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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
                        'login'.tr,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.white),
                      ),
                      8.sH,
                      Text(
                        'loginSubtitle'.tr,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                  child: Form(
                    key: controller.loginKey,
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
                          controller: controller.email,
                          validator: (v) => BValidators.validateEmail(v),
                          hintText: 'email'.tr,
                          isPrefixIcon: true,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: CupertinoIcons.mail,
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: (v) {
                                  controller.rememberMe.value = !controller.rememberMe.value;
                                },
                              ),
                            ),
                            Text(
                              'rememberMe'.tr,
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Get.to(() => ForgotPasswordScreen());
                              },
                              child: Text('forgotPasswordButton'.tr),
                            ),
                          ],
                        ),
                        25.sH,
                        CustomButton(
                          text: 'login'.tr,
                          onTapped: () {
                            if (controller.loginKey.currentState!.validate()) {
                              controller.isDeactivated.value
                                  ? showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg * 2)),
                                          backgroundColor: AppColors.kPrimaryColor,
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'accountDeactivated'.tr,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.white),
                                                ),
                                                const SizedBox(height: kToolbarHeight / 2),
                                                Text(
                                                  'youraccounthasbeendeactivated.'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(color: AppColors.white, fontWeight: FontWeight.w300),
                                                ),
                                                20.sH,
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('ok'.tr),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : controller.login();
                            }
                          },
                        ),
                        15.sH,
                        Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'don’tHaveAnAccount?'.tr, style: Theme.of(context).textTheme.bodySmall),
                                TextSpan(
                                    text: 'signup'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(() => SignUpScreen());
                                      }),
                              ],
                            ),
                          ),
                        ),
                        15.sH,
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            8.sW,
                            Text(
                              'or'.tr,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.greyColor),
                            ),
                            8.sW,
                            const Expanded(child: Divider()),
                          ],
                        ),
                        15.sH,
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
                                Get.to(() => const PhoneLoginScreen());
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
                )
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
      // Trigger Google Sign-In flow
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
          () => const SelectRoleScreen(),
        );
      }
    } catch (error) {
      print("Error signing in with Google: $error");
      // Handle error
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

        // Store user data in Firestore
        await usersCollection.doc(user.uid).set(userData);
      } catch (error) {
        print("Error storing user record: $error");
        // Handle error
      }
    }
  }
}
