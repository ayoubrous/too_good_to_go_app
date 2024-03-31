import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constant/app_colors.dart';

class SocialIocns extends StatelessWidget {
  final Widget widget;
  final VoidCallback ontapped;

  const SocialIocns({super.key, required this.widget, required this.ontapped});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: ontapped,
        child: CircleAvatar(

          radius: 25,
          backgroundColor: AppColors.textFieldGreyColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      ),
    );
  }
}
