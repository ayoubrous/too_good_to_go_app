import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/sizes.dart';
import '../../../elements/custom_back_button.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? _selectedStoreType;
  String? _selectedFoodType;
  double _selectedBudgetMin = 2.0;
  double _selectedBudgetMax = 100.0;
  TimeOfDay _startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 23, minute: 59);
  double _selectedDistance = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
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
              Wrap(
                spacing: 8.0,
                children: [
                  _buildChip('Bakery'),
                  _buildChip('Restaurant'),
                  _buildChip('Cafe'),
                  _buildChip('Super Market'),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'foodType'.tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8.0,
                children: [
                  _buildChip('Vegetairan'),
                  _buildChip('Vegan'),
                  _buildChip('Nonvegan'),
                ],
              ),
              15.sH,
              Text(
               "budget".tr +'${_selectedBudgetMin.toStringAsFixed(2)} - ${_selectedBudgetMax.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              RangeSlider(
                values: RangeValues(_selectedBudgetMin, _selectedBudgetMax),
                activeColor: AppColors.kPrimaryColor,
                min: 2.0,
                max: 100.0,
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
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: _startTime,
                        );
                        if (selectedTime != null) {
                          setState(() {
                            _startTime = selectedTime;
                          });
                        }
                      },
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                        child: FittedBox(
                          child: Text(
                            'From: ${_startTime.format(context)}',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    height: 40,
                    width: 1,
                    color: AppColors.greyColor,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: _endTime,
                        );
                        if (selectedTime != null) {
                          setState(() {
                            _endTime = selectedTime;
                          });
                        }
                      },
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                        child: FittedBox(
                          child: Text(
                            'To: ${_endTime.format(context)}',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              15.sH,
              Text(
                'Distance: ${_selectedDistance.toStringAsFixed(2)} miles',
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
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: AppColors.kPrimaryColor),
                              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
                        ),
                        onPressed: () {},
                        child: Text(
                          'cancel'.tr,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                  10.sW,
                  Expanded(child: CustomButton(text: 'apply'.tr, onTapped: () {})),
                ],
              ),
              10.sH,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return ChoiceChip(
      side: BorderSide(color: Colors.transparent),
      backgroundColor: AppColors.kPrimaryColor.withOpacity(0.3),
      selectedColor: AppColors.kPrimaryColor,
      checkmarkColor: AppColors.white,
      labelStyle: TextStyle(color: AppColors.white),
      label: Text(label),
      selected: label == _selectedStoreType || label == _selectedFoodType,
      onSelected: (bool selected) {
        setState(() {
          if (label == 'Bakery' || label == 'Restaurant' || label == 'Cafe') {
            _selectedStoreType = selected ? label : null;
          } else {
            _selectedFoodType = selected ? label : null;
          }
        });
      },
    );
  }
}
