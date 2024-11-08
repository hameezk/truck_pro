import '../utilities/app_colors.dart';
import '../utilities/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obsureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obsureText = false,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        obscureText: obsureText,
        style: const TextStyle(color: AppColors.whiteColor),
        controller: controller,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          fillColor: AppColors.backGroundColor,
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintText: hintText,
          hintStyle: headingSM.copyWith(
              color: AppColors.whiteColor.withOpacity(0.25), fontSize: 14),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.whiteColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.whiteColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.whiteColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
