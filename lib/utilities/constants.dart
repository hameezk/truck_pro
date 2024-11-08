import 'app_colors.dart';
import 'assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle headingSM = GoogleFonts.poppins(
    color: AppColors.whiteColor, fontWeight: FontWeight.w400);
TextStyle headingLG = GoogleFonts.poppins(
    fontSize: 40, color: AppColors.whiteColor, fontWeight: FontWeight.bold);
TextStyle headingMD = GoogleFonts.roboto(
    fontSize: 28, color: AppColors.whiteColor, fontWeight: FontWeight.w700);

RegExp emailRegExp =
    RegExp(r'^[a-zA-Z0-9._%+-]{1,}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

SizedBox heightSizedBox10 = const SizedBox(height: 10);
SizedBox heightSizedBox20 = const SizedBox(height: 20);
SizedBox heightSizedBox30 = const SizedBox(height: 30);

SizedBox widthSizedBox10 = const SizedBox(width: 10);
SizedBox widthheightSizedBox20 = const SizedBox(width: 20);
SizedBox widthheightSizedBox30 = const SizedBox(width: 30);

TextTheme textThemeData(BuildContext context) {
  return Theme.of(context).textTheme;
}

List images = [
  AssetsManager.attendence,
  AssetsManager.employee,
  AssetsManager.payroll,
  AssetsManager.expense,
];

List containerText = [
  'Attendence\nManagement',
  'Employee\nManagement',
  'Payroll\nManagement',
  'Expense\nManagement',
];
List userProfileIcons = [
  AssetsManager.person,
  AssetsManager.payment,
  AssetsManager.work,
  AssetsManager.work,
  AssetsManager.detail,
  AssetsManager.detail,
];

List userProfileDetailText = [
  'Personal detail',
  'Payment detail',
  'Work details',
  'Duty management',
  'Deactivate account',
  'Transcation History',
];
