import '../utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showFlutterToast(
  BuildContext context, {
  required String message,
  required errorInfo,
}) {
  FToast fToast = FToast();

  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
    decoration: BoxDecoration(
      color: errorInfo == 'error' ? Colors.red : Colors.green,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        errorInfo == 'error'
            ? const Icon(
                Icons.cancel,
                color: AppColors.whiteColor,
              )
            : const Icon(
                Icons.check,
                color: AppColors.whiteColor,
              ),
        const SizedBox(width: 10),
        Text(
          message,
          style: const TextStyle(color: AppColors.whiteColor),
        ),
      ],
    ),
  );
  fToast.showToast(child: toast, gravity: ToastGravity.BOTTOM);
}
