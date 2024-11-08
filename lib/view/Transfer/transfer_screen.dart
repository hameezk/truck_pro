import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../../routes/routes_name.dart';
import '../../utilities/screen_sizes.dart';
import '../Login/login_screen.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              title: 'Transfer',
              backGroundColor: AppColors.backGroundColor,
              showBackButton: true,
              foreGroundColor: AppColors.whiteColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.greyColor),
                        ),
                        heightSizedBox10,
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.blackColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Account',
                                style: textThemeData(context).headlineSmall,
                              ),
                              Text(
                                '00342745928',
                                style: textThemeData(context).headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        heightSizedBox10,
                        Text(
                          'To',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.greyColor),
                        ),
                        heightSizedBox10,
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColors.whiteColor,
                                        foregroundColor: AppColors.whiteColor,
                                        radius: 30,
                                        child: Image.asset(
                                            AssetsManager.sampleImage),
                                      ),
                                      heightSizedBox10,
                                      Text(
                                        'Aliya',
                                        style: textThemeData(context)
                                            .headlineSmall!
                                            .copyWith(
                                                color: AppColors.greyColor,
                                                fontSize: 12),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                        heightSizedBox20,
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.whiteColor,
                              foregroundColor: AppColors.whiteColor,
                              radius: 25,
                              child: Icon(
                                Icons.search,
                                color: AppColors.blackColor,
                              ),
                            ),
                            widthSizedBox10,
                            const Expanded(
                              child: CustomTextField(hintText: 'Search...'),
                            ),
                          ],
                        ),
                        heightSizedBox20,
                        Text(
                          'Amount',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.greyColor),
                        ),
                        const UnderLineTextField(hintText: 'amount'),
                        heightSizedBox10,
                        Text(
                          'Purpose',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.greyColor),
                        ),
                        const UnderLineTextField(hintText: 'amount'),
                        heightSizedBox10,
                        Text(
                          'Account # / IBAN',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.greyColor),
                        ),
                        const UnderLineTextField(hintText: 'amount'),
                        heightSizedBox10,
                        Text(
                          'Account title',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.greyColor),
                        ),
                        const UnderLineTextField(hintText: 'amount'),
                        heightSizedBox10,
                        Text(
                          'Current Rate',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.greyColor),
                        ),
                        const UnderLineTextField(hintText: 'amount'),
                        heightSizedBox10,
                        Text(
                          'Payment slip',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.greyColor),
                        ),
                        heightSizedBox10,
                        Container(
                          height: screenHeight(context) * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.blackColor),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: AppColors.greyColor,
                              size: 50,
                            ),
                          ),
                        ),
                        heightSizedBox30,
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.inVoice);
                          },
                          child:
                              const CustomButton(buttonText: 'Create Invoice'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UnderLineTextField extends StatelessWidget {
  final String hintText;
  final bool obsureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  const UnderLineTextField({
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
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.whiteColor.withOpacity(0.5)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.whiteColor.withOpacity(0.5)),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.whiteColor.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}
