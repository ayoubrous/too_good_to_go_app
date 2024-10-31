import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/controller/filter_controller.dart';
import 'package:too_good_to_go_app/presentation/elements/choice_chip_widget.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/filter_screen/widget/filter_product_view.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/sizes.dart';
import '../../../elements/custom_back_button.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _selectedBudgetMin = 0;
  double _selectedBudgetMax = 5000;

  double _selectedDistance = 10.0;
  final filterController = Get.put(FilterController());
  TimeOfDay? selectedstartTime;
  TimeOfDay? selectedendTime;

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (isStartTime) {
        setState(() {
          selectedstartTime = picked;
        });
      } else {
        setState(() {
          selectedendTime = picked;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: Text('filter'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'storeType'.tr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                8.sH,
                filterController.businessCatList.isEmpty
                    ? Center(
                        child: Text(
                        'notAddedYet'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                    : SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: filterController.businessCatList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            var businessData = filterController.businessCatList[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Obx(
                                () => ChoiceChipWidget(
                                  label: businessData['name'],
                                  isSelected:
                                      filterController.selectedBusinessCatId.value == businessData['businessCatId']
                                          ? true
                                          : false,
                                  onSelected: () {
                                    filterController.select(
                                        businessData['businessCatId'], filterController.selectedBusinessCatId.value);
                                    filterController.selectedBusinessCatId.value = businessData['businessCatId'];
                                    print(filterController.selectedBusinessCatId.value);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(height: 16.0),
                Text(
                  'foodType'.tr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                8.sH,
                filterController.menList.isEmpty
                    ? Center(
                        child: Text(
                        'notAddedYet'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                    : SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: filterController.menList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            var menuData = filterController.menList[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Obx(
                                () => ChoiceChipWidget(
                                  label: menuData['name'],
                                  isSelected:
                                      filterController.selectedMenuId.value == menuData['menuId'] ? true : false,
                                  onSelected: () {
                                    filterController.select(menuData['menuId'], filterController.selectedMenuId.value);
                                    filterController.selectedMenuId.value = menuData['menuId'];
                                    print(filterController.selectedMenuId.value);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                15.sH,
                Text(
                  "budget".tr +
                      ":\t" '${_selectedBudgetMin.round().toString()} - ${_selectedBudgetMax.round().toString()}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                RangeSlider(
                  values: RangeValues(_selectedBudgetMin, _selectedBudgetMax),
                  activeColor: AppColors.kPrimaryColor,
                  min: 0,
                  max: 5000,
                  divisions: 98,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _selectedBudgetMin = values.start;
                      _selectedBudgetMax = values.end;
                    });
                  },
                ),
                15.sH,
                Text(
                  'pickUpTime'.tr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                10.sH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          selectTime(context, true);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            selectedstartTime == null
                                ? 'startTime'.tr
                                : '${selectedstartTime!.format(context).toString()}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    10.sW,
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          selectTime(context, false);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            selectedendTime == null ? 'endTime'.tr : '${selectedendTime!.format(context).toString()}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                15.sH,
                Text(
                  'distance'.tr + "\t${_selectedDistance.toStringAsFixed(2)}" + "mile".tr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                Slider(
                  activeColor: AppColors.kPrimaryColor,
                  value: _selectedDistance,
                  min: 1.0,
                  max: 50.0,
                  divisions: 49,
                  onChanged: (double value) {
                    setState(() {
                      _selectedDistance = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 58,
                        child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: AppColors.kPrimaryColor),
                                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'cancel'.tr,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                    10.sW,
                    Expanded(
                      child: CustomButton(
                        text: 'apply'.tr,
                        onTapped: () {
                          //filterController.filter();
                          filterController.filter(
                            maxPrice: _selectedBudgetMax.round().toString(),
                            minPrice: _selectedBudgetMin.round().toString(),
                            menuID: filterController.selectedMenuId.value,
                            businessCatId: filterController.selectedBusinessCatId.value,
                            selectedstartTime: selectedstartTime!.format(context).toString(),
                            selectedendTime: selectedendTime!.format(context).toString(),
                          );
                          Get.to(
                            () => FilterProductView(
                              filterProductList: filterController.filterProduct.stream,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                10.sH,
              ],
            ),
          ),
        ),
      ),
    );
  }


}
