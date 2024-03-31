import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/presentation/elements/primary_header_appbar.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/forgot_password_screen/forgot_password_screen.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/phone_login_screen/phone_login_screen.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/signup_screen/signup_screen.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/navigation_bar_view/navigation_bar_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/image_string.dart';
import 'widget/social_icons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  15.sH,
                  CustomTextField(
                    hintText: 'email'.tr,
                    isPrefixIcon: true,
                    prefixIcon: CupertinoIcons.mail,
                  ),
                  CustomTextField(
                    hintText: 'password'.tr,
                    isPrefixIcon: true,
                    prefixIcon: Iconsax.password_check,
                    isPasswordField: true,
                    obsecureText: true,
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (v) {},
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
                      Get.offAll(() => NavigationBarScreen());
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
                        ontapped: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
// ElevatedButton(
// onPressed: () async {
// User? user = await signInWithGoogle();
// if (user != null) {
// await addUserToFirestore(user);
// }
// },
// child: Text('Sign in with Google'),
// ),
/// for adding data in google sign in
// Future<void> addUserToFirestore(User user) async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   await firestore.collection('users').doc(user.uid).set({
//     'displayName': user.displayName,
//     'email': user.email,
//     'photoURL': user.photoURL,
//     // Add additional data here
//   });
// }

///
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();
//
// Future<User?> signInWithGoogle() async {
//   try {
//     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       final UserCredential authResult = await _auth.signInWithCredential(credential);
//       final User? user = authResult.user;
//
//       return user;
//     }
//   } catch (error) {
//     print('Google Sign-In Error: $error');
//     return null;
//   }
// }
