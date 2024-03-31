import 'package:flutter/material.dart';

import '../../../../../utils/constant/app_colors.dart';

class CategoriesCards extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String img;

  const CategoriesCards({super.key, required this.onTap, required this.title, required this.img});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                height: 60,
                width: 60,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.textFieldGreyColor),
                child: Image.asset(
                  img,
                ),
              ),
              Center(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
