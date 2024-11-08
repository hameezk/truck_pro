// ignore_for_file: prefer_const_constructors

import '../../utilities/constants.dart';
import '../../routes/routes_name.dart';
import '../Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primaryColor,
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Image.asset(AssetsManager.sampleImage),
                        ),
                        heightSizedBox10,
                        Text(
                          'Welcome back!',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.blackColor),
                        ),
                        Text(
                          "Abdullah khan",
                          style: textThemeData(context).headlineSmall!.copyWith(
                              color: AppColors.blackColor.withOpacity(0.5)),
                        )
                      ],
                    ),
                  ),
                ),
                heightSizedBox30,
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.backGroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: Column(
                            children: [
                              Text(
                                'Enter your PIN',
                                style: textThemeData(context)
                                    .headlineLarge!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              heightSizedBox10,
                              Text(
                                'Enter the 4 digit code to login',
                                style: textThemeData(context)
                                    .headlineSmall!
                                    .copyWith(color: AppColors.greyColor),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: PinCodeTextField(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              length: 4,
                              appContext: context,
                              autoDisposeControllers: false,
                              onCompleted: (value) {},
                              textStyle:
                                  const TextStyle(color: AppColors.whiteColor),
                              keyboardType: TextInputType.number,
                              enableActiveFill: true,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(10),
                                fieldHeight: 60,
                                fieldWidth: 55,
                                borderWidth: 1,
                                activeColor: AppColors.greyColor,
                                inactiveColor: AppColors.greyColor,
                                selectedColor: AppColors.greyColor,
                                activeFillColor: AppColors.greyColor,
                                inactiveFillColor: AppColors.greyColor,
                                selectedFillColor: AppColors.greyColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.navBar);
                            },
                            child: CustomButton(
                              buttonText: 'Verify',
                              horizontalButtonPadding: 25,
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
        ),
      ),
    );
  }
}
