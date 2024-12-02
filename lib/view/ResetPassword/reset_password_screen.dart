import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../Login/login_screen.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.backGroundColor,
          body: Column(
            children: [
              const CustomAppBar(
                title: 'Reset Password',
                foreGroundColor: AppColors.whiteColor,
                backGroundColor: AppColors.backGroundColor,
                showBackButton: true,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            CircleAvatar(
                              foregroundColor: AppColors.whiteColor,
                              backgroundColor: AppColors.whiteColor,
                              radius: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(AssetsManager.lockImage),
                              ),
                            ),
                            heightSizedBox30,
                            SizedBox(
                              child: RichText(
                                text: TextSpan(
                                  style: textThemeData(context).headlineSmall,
                                  children: const [
                                    TextSpan(
                                      text:
                                          'If your email is in our database as on user, we will send you an e-mail with a link to reset your password. If you don\'t recieve an e-mail, it is not in our database.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: textThemeData(context).headlineSmall,
                            ),
                            heightSizedBox10,
                            const CustomTextField(hintText: 'Enter your email'),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: GestureDetector(
                          onTap: () {
                            resetPassword(context);
                          },
                          child: const CustomButton(
                            buttonText: 'Send email',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) {}
}
