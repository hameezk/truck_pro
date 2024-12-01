import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:truck_pro/utilities/app_colors.dart';
import 'package:truck_pro/utilities/constants.dart';

import '../utilities/assets_manager.dart';
import '../utilities/screen_sizes.dart';

void showLoadingDialog(BuildContext context, String title) {
  AlertDialog loadingDialog = AlertDialog(
    content: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Animate(
            effects: [FadeEffect()],
            child: Image.asset(
              AssetsManager.logo,
              height: screenHeight(context) * 0.15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: headingSM.copyWith(color: AppColors.backGroundColor),
          ).animate(
            effects: [FadeEffect()],
          ),
        ],
      ),
    ),
  );
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return loadingDialog;
      });
}
