import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../utils/constant/app_colors.dart';

void showPrivacyPolicyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('PrivacyPolicy'.tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: AppColors.kPrimaryColor)),
          ),
        ],
      );
    },
  );
}
