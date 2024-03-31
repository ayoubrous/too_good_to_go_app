import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/primary_header_appbar.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/login_screen/login_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/decider.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

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
                      20.sW,
                      Expanded(
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
                    ],
                  ),
                  40.sH,
                  CustomButton(
                    text: 'done'.tr,
                    onTapped: () {
                      Get.offAll(() => LoginScreen());
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
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class RoleSelectionScreen extends StatefulWidget {
//   @override
//   _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
// }
//
// class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
//   bool _isBusiness = false; // Default to customer account
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   void _selectRole(BuildContext context) async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//
//       if (user != null) {
//         // Store the user's role in Firestore
//         await _firestore.collection('users').doc(user.uid).set({
//           'isBusiness': _isBusiness,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Role selected successfully.'),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('User not authenticated.'),
//         ));
//       }
//     } catch (error) {
//       // Handle errors
//       print('Error selecting role: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to select role. Error: $error'),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Role'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             RadioListTile(
//               title: Text('Customer Account'),
//               value: false,
//               groupValue: _isBusiness,
//               onChanged: (bool? value) {
//                 setState(() {
//                   _isBusiness = false;
//                 });
//               },
//             ),
//             RadioListTile(
//               title: Text('Business Account'),
//               value: true,
//               groupValue: _isBusiness,
//               onChanged: (bool? value) {
//                 setState(() {
//                   _isBusiness = true;
//                 });
//               },
//             ),
//             ElevatedButton(
//               onPressed: () => _selectRole(context),
//               child: Text('Continue'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: RoleSelectionScreen(),
//   ));
// }
