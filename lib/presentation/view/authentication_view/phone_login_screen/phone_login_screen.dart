import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/view/authentication_view/otp_screen/otp_screen.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/app_colors.dart';
import '../../../../utils/constant/image_string.dart';
import '../../../elements/primary_header_appbar.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  Country selectedCountry = Country(
    phoneCode: '352',
    countryCode: 'LU',
    e164Sc: 1,
    geographic: true,
    level: 1,
    name: 'Luxembourg',
    example: 'Luxembourg',
    displayName: 'Luxembourg',
    displayNameNoCountryCode: 'LU',
    e164Key: '',
  );
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

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
                    'signInwithPhone'.tr,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.white),
                  ),
                  8.sH,
                  Text(
                    'signInwithPhoneSubtitle'.tr,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Column(
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
                  TextFormField(
                    onChanged: (v) {
                      setState(() {
                        phoneController.text = v;
                      });
                    },
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: AppColors.textFieldGreyColor,
                      hintStyle: const TextStyle(color: AppColors.blackTextColor, fontSize: 14),
                      hintText: 'enterPhoneNumber'.tr,
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                              useSafeArea: true,
                              showPhoneCode: true,
                              countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 500,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(AppSizes.borderRadiusLg),
                                ),
                              ),
                              context: context,
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              },
                            );
                          },
                          child: Text(
                            "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                      suffixIcon: phoneController.text.length > 9
                          ? Container(
                              margin: EdgeInsets.only(right: 12),
                              child: Icon(
                                Iconsax.tick_circle5,
                                size: 22,
                                color: Colors.green,
                              ),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                          borderSide: BorderSide(
                            color: AppColors.kPrimaryColor.withOpacity(0.3),
                          )),
                    ),
                  ),
                  40.sH,
                  CustomButton(
                    text: 'login'.tr,
                    onTapped: () {
                      Get.to(() => OtpScreen());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
