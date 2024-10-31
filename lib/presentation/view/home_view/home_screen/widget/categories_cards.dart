import 'package:cached_network_image/cached_network_image.dart';
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
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.kPrimaryColor,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      placeholder: (context, url) {
                        return const Placeholder(
                          strokeWidth: 0.1,
                          color: AppColors.textFieldGreyColor,
                          child: Icon(
                            Icons.downloading,
                            color: AppColors.lightRed,
                          ),
                        );
                      },
                      imageUrl: img,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
