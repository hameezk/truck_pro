// ignore_for_file: prefer_const_constructors

import '../utilities/screen_sizes.dart';
import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Color? foreGroundColor;
  final Color? backGroundColor;
  final bool? showBackButton;
  const CustomAppBar({
    super.key,
    required this.title,
    this.foreGroundColor,
    this.backGroundColor,
    this.showBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: backGroundColor ?? AppColors.whiteColor),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                showBackButton ?? false
                    ? SizedBox(
                        height: 50,
                        width: 60,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,
                              color: foreGroundColor ?? AppColors.whiteColor),
                        ),
                      )
                    : SizedBox(
                        width: screenWidth(context) * 0.33,
                      ),
                showBackButton == true
                    ? SizedBox(width: screenWidth(context) * 0.2)
                    : SizedBox(),
                Text(
                  title,
                  style: TextStyle(
                    color: foreGroundColor ?? AppColors.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
