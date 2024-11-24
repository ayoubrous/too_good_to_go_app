import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../utils/constant/app_colors.dart';

void showTermOfServicesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('termOfServices'.tr,
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
                'introduction'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'WelcometoTheseTermsofServicegovernyouruseofourapplicationByusingourapplicationyouagreetotheseTermsofService'
                    .tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'useoftheApplication'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              5.sH,
              Text(
                'youagreeto'.tr,
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
                      'usetheapplicationinaccordancewithapplicablelawsandregulations'.tr,
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
                      'notusetheapplicationforillegalorfraudulentactivities'.tr,
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
                      'notinterferewiththeoperationoftheapplication'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              15.sH,
              Text(
                'userAccount'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'tousecertainfeaturesoftheapplicationyoumustcreateanaccountYouareresponsiblefortheconfidentialityofyouraccountandpassword'
                    .tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'userContent'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'youareresponsibleforanycontentyoupostontheapplicationYougrantanonexclusiveworldwideroyaltyfreetransferableandsublicensablelicensetousereproducemodifyadaptpublishtranslatecreatederivativeworksfromdistributeanddisplaysuchcontentinanyandallmediaordistributionmethods'
                    .tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'intellectualProperty'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'allintellectualpropertyrightsintheapplicationanditscontentbelongtoNameoritslicensorsYoumaynotusereproducedistributeormodifytheapplicationoritscontentwithoutourpriorwrittenpermission'
                    .tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'limitationofLiability'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'willnotbeliableforanyindirectincidentalspecialconsequentialorpunitivedamagesresultingfromtheuseoftheapplication'
                    .tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'indemnification'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'youagreetoindemnifyandholdharmlessfromanyclaimlossliabilitydamagecostandexpensearisingfromyouruseoftheapplicationoryourviolationoftheseTermsofService'
                    .tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'termination'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'wemayterminateorsuspendyouraccountandaccesstotheapplicationatanytimewithorwithoutnoticeforanyreasonincludingbutnotlimitedtoviolationoftheseTermsofService'
                    .tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'governingLaw'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'theseTermsofServicearegovernedbythelawsofMoroccoAnydisputearisingfromtheseTermsofServicewillbesubjecttotheexclusivejurisdictionofthecourtsofMorocco'
                    .tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'changestotheTermsofService'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'wemayupdatetheseTermsofServiceatanytimeChangeswillbepostedonthispagewiththedateofthelastupdate'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              15.sH,
              Text(
                'contact'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'foranyquestionsregardingtheseTermsofServicepleasecontactusat'.tr,
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
