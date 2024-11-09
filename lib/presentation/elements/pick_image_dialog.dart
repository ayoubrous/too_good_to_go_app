import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:too_good_to_go_app/utils/theme/theme.dart';

import '../../utils/constant/app_colors.dart';
import '../../utils/constant/sizes.dart';
import '../../utils/custom_shapes/circular_container.dart';

class PickImageDialog extends StatelessWidget {
  final VoidCallback cameraOnPressed;
  final VoidCallback galleryOnPressed;

  const PickImageDialog({super.key, required this.cameraOnPressed, required this.galleryOnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg, vertical: AppSizes.lg / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pick Image',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const CloseButton(),
            ],
          ),
          15.sH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularContainer(
                padding: const EdgeInsets.all(12),
                child: IconButton(
                  onPressed: cameraOnPressed,
                  icon: const Icon(
                    Iconsax.camera,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ),
              CircularContainer(
                padding: const EdgeInsets.all(12),
                child: IconButton(
                  onPressed: galleryOnPressed,
                  icon: const Icon(
                    Iconsax.gallery,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          15.sH,
        ],
      ),
    );
  }
}
