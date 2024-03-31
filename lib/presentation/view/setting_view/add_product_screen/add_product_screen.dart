import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_button.dart';
import 'package:too_good_to_go_app/presentation/elements/custom_text_field.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../../../utils/constant/app_colors.dart';
import '../../../elements/custom_back_button.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null && picked != _startTime) {
      if (_endTime != null && picked.hour > _endTime.hour) {
        setState(() {
          _startTime = _endTime.replacing(hour: picked.hour, minute: picked.minute);
          _startController.text = _startTime.format(context);
        });
      } else {
        setState(() {
          _startTime = picked;
          _startController.text = _startTime.format(context);
        });
      }
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null && picked != _endTime) {
      if (_startTime != null && picked.hour < _startTime.hour) {
        setState(() {
          _endTime = _startTime.replacing(hour: picked.hour, minute: picked.minute);
          _endController.text = _endTime.format(context);
        });
      } else {
        setState(() {
          _endTime = picked;
          _endController.text = _endTime.format(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title:  Text('addProduct'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.sH,
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.textFieldGreyColor,
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                  ),
                  child: const Icon(
                    Iconsax.camera,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ),
              20.sH,
              CustomTextField(hintText: 'productName'.tr),
              CustomTextField(hintText: 'productDescription'.tr),
              CustomTextField(hintText: 'totalItemLeft'.tr, textInputType: TextInputType.number),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(hintText: 'actualPrice'.tr, textInputType: TextInputType.number),
                  ),
                  10.sW,
                  Expanded(
                    child: CustomTextField(hintText: 'disPrice'.tr, textInputType: TextInputType.number),
                  ),
                ],
              ),
              8.sH,
              Text(
                'collectionTime'.tr,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      readOnly: true,
                      controller: _startController,
                      hintText: _startTime.format(context),
                      onTapped: () async {
                        _selectStartTime(context);
                      },
                    ),
                  ),
                  10.sW,
                  Expanded(
                    child: CustomTextField(
                      readOnly: true,
                      controller: _endController,
                      hintText: _endTime.format(context),
                      onTapped: () async {
                        _selectEndTime(context);
                      },
                    ),
                  ),
                ],
              ),
              ChoiceChip(
                side: const BorderSide(color: Colors.transparent),
                backgroundColor: AppColors.kPrimaryColor.withOpacity(0.5),
                selectedColor: AppColors.kPrimaryColor,
                checkmarkColor: AppColors.white,
                labelStyle: const TextStyle(color: AppColors.white),
                label: const Text('Meal'),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    isSelected = selected;
                  });
                },
              ),
              25.sH,
              CustomButton(text: 'upload'.tr, onTapped: () {}),
              20.sH,
            ],
          ),
        ),
      ),
    );
  }
}
