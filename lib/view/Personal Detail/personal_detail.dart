import '../../utilities/app_colors.dart';
import '../../widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants.dart';
import '../../widgets/custom_text_field.dart';
import '../Login/login_screen.dart';

class PersonalDetailScreen extends StatefulWidget {
  const PersonalDetailScreen({super.key});

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backGroundColor,
        body: Column(
          children: [
            const CustomAppBar(
              title: 'Personal detail',
              backGroundColor: AppColors.backGroundColor,
              showBackButton: true,
              foreGroundColor: AppColors.whiteColor,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            'Full Name',
                            style: textThemeData(context).headlineSmall,
                          ),
                          heightSizedBox10,
                          const CustomTextField(
                              hintText: 'Enter your full name'),
                          heightSizedBox10,
                          Text(
                            'Email',
                            style: textThemeData(context).headlineSmall,
                          ),
                          heightSizedBox10,
                          const CustomTextField(hintText: 'Enter your email'),
                          heightSizedBox10,
                          Text(
                            'Phone No.',
                            style: textThemeData(context).headlineSmall,
                          ),
                          heightSizedBox10,
                          const CustomTextField(hintText: 'Enter your email'),
                          heightSizedBox10,
                          Text(
                            'Enter daily wage',
                            style: textThemeData(context).headlineSmall,
                          ),
                          heightSizedBox10,
                          const CustomTextField(hintText: 'Enter daily wage'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        child: GestureDetector(
                          onTap: () {},
                          child:
                              const CustomButton(buttonText: 'Update details'),
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
