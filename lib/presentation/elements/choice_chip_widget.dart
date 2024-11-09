// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:too_good_to_go_app/controller/filter_controller.dart';
//
// class ChoiceChipWidget extends StatelessWidget {
//   final String label;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   ChoiceChipWidget({
//     Key? key,
//     required this.label,
//     required this.isSelected,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final filterController = Get.put(FilterController());
//     return ChoiceChip(
//       label: Text(label),
//       selected: isSelected,
//       onSelected: (selected) {
//         if (selected) onTap;
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/filter_controller.dart';

class ChoiceChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onSelected;

  const ChoiceChipWidget({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) {
          onSelected();
        }
      },
    );
  }
}
