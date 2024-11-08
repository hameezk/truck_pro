import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../../routes/routes_name.dart';
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
  bool hidePassword = true;
  bool hideReEnterPassword = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                            'Create accounts for \nEmployee',
                            textAlign: TextAlign.left,
                            style: headingMD,
                          ),
                          const SizedBox(height: 40),
                          Text(
                            'Full Name',
                            style: headingSM,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextField(
                              hintText: 'Enter your full name'),
                          const SizedBox(height: 10),
                          Text(
                            'Email',
                            style: headingSM,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextField(hintText: 'Enter your email'),
                          const SizedBox(height: 10),
                          Text(
                            'Password',
                            style: headingSM,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Enter your password',
                            obsureText: hidePassword,
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
                          const SizedBox(height: 10),
                          Text(
                            'Enter daily wage',
                            style: headingSM,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextField(hintText: 'Enter daily wage'),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.resetPassword);
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
