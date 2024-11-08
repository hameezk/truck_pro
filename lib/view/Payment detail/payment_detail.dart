import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/constants.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_field.dart';
import '../Login/login_screen.dart';

class PaymentDetailScreen extends StatefulWidget {
  const PaymentDetailScreen({super.key});

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backGroundColor,
        body: Column(
          children: [
            const CustomAppBar(
              title: 'Payment detail',
              backGroundColor: AppColors.backGroundColor,
              showBackButton: true,
              foreGroundColor: AppColors.whiteColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            'Bank Name',
                            style: textThemeData(context).headlineSmall,
                          ),
                          heightSizedBox10,
                          const CustomTextField(hintText: 'Enter bank name'),
                          heightSizedBox10,
                          Text(
                            'Account holder name',
                            style: textThemeData(context).headlineSmall,
                          ),
                          heightSizedBox10,
                          const CustomTextField(hintText: 'Enter account holder name'),
                          heightSizedBox10,
                          Text(
                            'Account number',
                            style: textThemeData(context).headlineSmall,
                          ),
                          heightSizedBox10,
                          const CustomTextField(hintText: 'Enter account number'),
                          heightSizedBox10,
                          Text(
                            'IBAN',
                            style: textThemeData(context).headlineSmall,
                          ),
                          heightSizedBox10,
                          const CustomTextField(hintText: 'Enter IBAN'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        child: GestureDetector(
                          onTap: () {},
                          child: const CustomButton(buttonText: 'Update details'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
