import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../utils/constant/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

   CustomLoader({Key? key, required this.isLoading, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      color: AppColors.kPrimaryColor,
      opacity: 0.2,
      progressIndicator: SpinKitWaveSpinner(
        trackColor: AppColors.textFieldGreyColor,
        waveColor: AppColors.kPrimaryColor,
        color: AppColors.kPrimaryColor,
        duration: Duration(seconds: 3),
        size: 50,
      ),
      child: child,
    );
  }
}
