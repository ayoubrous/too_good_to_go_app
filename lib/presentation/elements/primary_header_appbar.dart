import 'package:flutter/material.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';

import '../../utils/custom_shapes/circular_container.dart';
import '../../utils/custom_shapes/curved_edge_widget.dart';

class PrimaryHeaderAppBar extends StatelessWidget {
  const PrimaryHeaderAppBar({
    super.key,
    this.child,
    // this.height=350,
  });

  final Widget? child;

  // final double? height;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeContainerWidget(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.36,
        padding: const EdgeInsets.all(0),
        color: AppColors.kPrimaryColor,
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: CircularContainer(
                  bg: Colors.white.withOpacity(0.1),
                  borderColor: Colors.transparent,
                  height: 400,
                  width: 400,
                )),
            Positioned(
                top: 100,
                right: -300,
                child: CircularContainer(
                  bg: AppColors.white.withOpacity(0.1),
                  borderColor: Colors.transparent,
                  height: 400,
                  width: 400,
                )),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
