// ignore_for_file: avoid_unnecessary_containers

import '../../methods/navigate.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../Register/register_screen.dart';
import 'login_controller.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/screen_sizes.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.backGroundColor,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                AssetsManager.arrowImage,
                color: AppColors.primaryColor,
              ),
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Container(child: SizedBox(height: screenHeight(context) * 0.01)),

                          Container(
                            child: Text(
                              'Login',
                              style: headingLG,
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heightSizedBox10,
                                Text(
                                  'Email',
                                  style: headingSM,
                                ),
                                heightSizedBox10,
                                CustomTextField(
                                  controller: emailController,
                                  hintText: 'Enter email',
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Password',
                                  style: headingSM,
                                ),
                                heightSizedBox10,
                                CustomTextField(
                                  controller: passwordController,
                                  hintText: 'Enter password',
                                  obsureText: isObscure,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    child: isObscure
                                        ? const Icon(
                                            Icons.visibility_off,
                                            color: AppColors.whiteColor,
                                          )
                                        : const Icon(
                                            Icons.visibility_off,
                                            color: AppColors.whiteColor,
                                          ),
                                  ),
                                ),
                                heightSizedBox10,
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'Forget password?',
                                    style: headingSM.copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    validateLoginFields(context);
                                  },
                                  child: const CustomButton(
                                    buttonText: 'Login',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () =>
                                      navigate(context, RegisterScreen()),
                                  child: Text(
                                    'Don\'t hane an account?',
                                    style: headingSM.copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final double? horizontalButtonPadding;
  const CustomButton({
    super.key,
    required this.buttonText,
    this.horizontalButtonPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalButtonPadding!),
      child: Container(
        height: 50,
        width: screenWidth(context),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
                fontSize: 16,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
