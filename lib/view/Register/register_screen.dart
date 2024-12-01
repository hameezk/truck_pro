import 'package:truck_pro/view/Register/register_controller.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';
import '../Login/login_screen.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.backGroundColor,
          body: Stack(
            children: [
              Positioned(
                top: 100,
                child: Image.asset(
                  AssetsManager.arrowImage, color: AppColors.primaryColor,
                  //  fit: BoxFit.fitHeight,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(
                      title: '',
                      backGroundColor: AppColors.backGroundColor,
                      showBackButton: true,
                      foreGroundColor: AppColors.whiteColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create account for',
                            textAlign: TextAlign.left,
                            style: headingMD,
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                                height: 50,
                                width: screenWidth(context),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () => setState(() {
                                        registerAsUser = true;
                                      }),
                                      child: Container(
                                        height: 50,
                                        width:
                                            (screenWidth(context) * 0.5) - 48,
                                        decoration: BoxDecoration(
                                            color: (registerAsUser)
                                                ? AppColors.backGroundColor
                                                : AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppColors.primaryColor,
                                            )),
                                        child: Center(
                                          child: Text(
                                            'Dispatcher',
                                            style: headingSM.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: (registerAsUser)
                                                  ? AppColors.primaryColor
                                                  : AppColors.backGroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => setState(() {
                                        registerAsUser = false;
                                      }),
                                      child: Container(
                                        height: 50,
                                        width:
                                            (screenWidth(context) * 0.5) - 48,
                                        decoration: BoxDecoration(
                                            color: (registerAsUser)
                                                ? AppColors.primaryColor
                                                : AppColors.backGroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppColors.primaryColor,
                                            )),
                                        child: Center(
                                          child: Text(
                                            'Driver',
                                            style: headingSM.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: (registerAsUser)
                                                    ? AppColors.backGroundColor
                                                    : AppColors.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Full Name',
                            style: headingSM,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Enter your full name',
                            controller: nameController,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Email',
                            style: headingSM,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Enter your email',
                            controller: emailController,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Phone No.',
                            style: headingSM,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Enter your Phone No.',
                            controller: phonenoController,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Password',
                            style: headingSM,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Enter your password',
                            obsureText: hidePassword,
                            controller: passwordController,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              child: hidePassword
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
                          const SizedBox(height: 10),
                          Text(
                            'Re-enter password',
                            style: headingSM,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Enter your password again',
                            obsureText: hideReEnterPassword,
                            controller: cPasswordController,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hideReEnterPassword = !hideReEnterPassword;
                                });
                              },
                              child: hideReEnterPassword
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
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              checkValues(context);
                            },
                            child: const CustomButton(
                                buttonText: 'Create account'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
