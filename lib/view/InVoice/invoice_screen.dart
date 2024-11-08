import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';
import 'package:flutter/material.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: screenHeight(context) * 0.25,
                  child: Image.asset(
                    AssetsManager.logo,
                  ),
                ),
              ),
              heightSizedBox30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'FROM:',
                    style: textThemeData(context)
                        .headlineSmall!
                        .copyWith(fontSize: 16),
                  ),
                  Text(
                    'INVOICE',
                    style: textThemeData(context)
                        .headlineSmall!
                        .copyWith(color: AppColors.primaryColor, fontSize: 30),
                  ),
                ],
              ),
              heightSizedBox20,
              const InVoiceDetailRow(
                  text1: 'Abdullah khan', text2: 'Date : 10/06/2024'),
              const InVoiceDetailRow(
                  text1: '4567 876 466 89', text2: 'Ref: INVI09'),
              const InVoiceDetailRow(
                  text1: 'Mobile Report', text2: 'Bank detail'),
              heightSizedBox30,
              Text(
                'TO:',
                style: textThemeData(context)
                    .headlineSmall!
                    .copyWith(fontSize: 16),
              ),
              heightSizedBox30,
              Text(
                'Ethan Clark',
                style: textThemeData(context)
                    .headlineSmall!
                    .copyWith(fontSize: 14, color: AppColors.greyColor),
              ),
              Text(
                '1234 5467 4444 8858',
                style: textThemeData(context)
                    .headlineSmall!
                    .copyWith(fontSize: 14, color: AppColors.greyColor),
              ),
              Text(
                'Ethan Clark',
                style: textThemeData(context)
                    .headlineSmall!
                    .copyWith(fontSize: 14, color: AppColors.greyColor),
              ),
              heightSizedBox20,
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(color: AppColors.primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'SL',
                      style: textThemeData(context).headlineSmall!.copyWith(
                          fontSize: 14,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Subscription Detail',
                      style: textThemeData(context).headlineSmall!.copyWith(
                          fontSize: 14,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Price',
                      style: textThemeData(context).headlineSmall!.copyWith(
                          fontSize: 14,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              heightSizedBox10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '1',
                    style: textThemeData(context)
                        .headlineSmall!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '49.KR each month',
                    style: textThemeData(context)
                        .headlineSmall!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '49KR',
                    style: textThemeData(context)
                        .headlineSmall!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              heightSizedBox20,
              const Divider(
                color: AppColors.blueColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(),
                  Text(
                    'Total Due: ',
                    style: textThemeData(context).headlineSmall!.copyWith(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '49KR',
                    style: textThemeData(context).headlineSmall!.copyWith(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const Divider(
                color: AppColors.blueColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InVoiceDetailRow extends StatelessWidget {
  final String text1;
  final String text2;
  const InVoiceDetailRow({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: textThemeData(context)
              .headlineSmall!
              .copyWith(fontSize: 14, color: AppColors.greyColor),
        ),
        Text(
          text2,
          style: textThemeData(context)
              .headlineSmall!
              .copyWith(fontSize: 14, color: AppColors.greyColor),
        ),
      ],
    );
  }
}
