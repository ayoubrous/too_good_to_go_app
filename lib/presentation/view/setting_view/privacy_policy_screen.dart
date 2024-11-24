// import 'package:flutter/material.dart';
// import 'package:too_good_to_go_app/utils/constant/sizes.dart';
// import 'package:too_good_to_go_app/utils/theme/theme.dart';
//
// import '../../../utils/constant/app_colors.dart';
//
// class PrivacyPolicyScreen extends StatelessWidget {
//   const PrivacyPolicyScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Privacy Policy'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               15.sH,
//               Text('Privacy Policy',
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleSmall!
//                       .copyWith(color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold)),
//               15.sH,
//               Text(
//                 'Introduction',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 'Welcome to [Your App Name]. This Privacy Policy explains how we collect, use, disclose, and protect your personal information when you use our application. By using our application, you agree to the practices described in this Privacy Policy.',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               15.sH,
//               Text(
//                 'Collection of Information',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//               ),
//               5.sH,
//               Text(
//                 'We collect the following information:',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               10.sH,
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Personal Information: Name, email address, phone number, postal address.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Payment Information: Credit card details or other payment methods.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Location Information: Your geographical location to provide local services',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Browsing Information: Data about your use of the application, including pages visited and interactions.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               15.sH,
//               Text(
//                 'Use of Information',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//               ),
//               5.sH,
//               Text(
//                 'We use your information to:',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               10.sH,
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Provide and improve our services.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Personalize your user experience.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Communicate with you about your account and our services.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Perform analytics and research to improve our services.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               15.sH,
//               Text(
//                 'Sharing of Information',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//               ),
//               5.sH,
//               Text(
//                 'We may share your information with:',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               10.sH,
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Business Partners: To provide joint services.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Service Providers: To help us provide our services.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Legal Authorities: If we are legally required to do so.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               15.sH,
//               Text(
//                 'Security',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 'We take reasonable measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction.',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               15.sH,
//               Text(
//                 'Your Rights',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//               ),
//               5.sH,
//               Text(
//                 'You have the right to:',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               10.sH,
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Access your personal information.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Correct or update your personal information.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Request the deletion of your personal information',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 8),
//                     alignment: Alignment.centerLeft,
//                     height: 4,
//                     width: 4,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
//                   ),
//                   10.sW,
//                   Expanded(
//                     child: Text(
//                       'Object to the processing of your personal information.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               15.sH,
//               Text(
//                 'Changes to the Privacy Policy',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 'We may update this Privacy Policy at any time. Changes will be posted on this page with the date of the last update.',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               15.sH,
//               Text(
//                 'Contact',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 'For any questions regarding this Privacy Policy, please contact us at [contact email address].',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               15.sH,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../utils/constant/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PrivacyPolicy'.tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.sH,
              Text('PrivacyPolicy'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold)),
              15.sH,
              Text(
                'Introduction'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'IntroSubTitle'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'CollectionofInformation'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              5.sH,
              Text(
                'Wecollectthefollowinginformation'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              10.sH,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'PersonalInformationNameEmailAddressphonenumberpostaladdress'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'PaymentInformationCreditcarddetailsorotherpaymentmethods.'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'LocationInformationYourgeographicallocationtoprovidelocalservices'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'BrowsingInformationDataaboutyouruseoftheapplicationincludingpagesvisitedandinteractions'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              15.sH,
              Text(
                'UseofInformation'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              5.sH,
              Text(
                'Weuseyourinformationto'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              10.sH,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'Provideandimproveourservices'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'Personalizeyouruserexperience'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'Communicatewithyouaboutyouraccountandourservices'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'Performanalyticsandresearchtoimproveourservices'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              15.sH,
              Text(
                'SharingofInformation'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              5.sH,
              Text(
                'Wemayshareyourinformationwith'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              10.sH,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'BusinessPartnersToprovidejointservices'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'ServiceProvidersTohelpusprovideourservices'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'LegalAuthoritiesIfwearelegallyrequiredtodoso'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              15.sH,
              Text(
                'security'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Wetakereasonablemeasurestoprotectyourpersonalinformationfromunauthorizedaccessdisclosurealterationordestruction'
                    .tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'yourRights'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              5.sH,
              Text(
                'youhavetherightto'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              10.sH,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'accessyourpersonalinformation'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'correctorupdateyourpersonalinformation'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'requestthedeletionofyourpersonalinformation'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackTextColor),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'objecttotheprocessingofyourpersonalinformation'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              15.sH,
              Text(
                'changestothePrivacyPolicy'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'wemayupdatethisPrivacyPolicyatanytimeChangeswillbepostedonthispagewiththedateofthelastupdate'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'contact'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'foranyquestionsregardingthisPrivacyPolicypleasecontactusatcontactemailaddress'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
            ],
          ),
        ),
      ),
    );
  }
}
