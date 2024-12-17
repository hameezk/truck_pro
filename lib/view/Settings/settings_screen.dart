import 'package:firebase_auth/firebase_auth.dart';
import 'package:truck_pro/methods/loading_dialog.dart';
import 'package:truck_pro/methods/navigate.dart';
import 'package:truck_pro/models/user_model.dart';
import 'package:truck_pro/view/SplashScreen/splash_screen.dart';
import 'package:truck_pro/view/profile/edit_profile_screen.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';
import 'package:flutter/material.dart';
import '../../utilities/app_colors.dart';
import '../../widgets/custom_appbar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: Column(
          children: [
            const CustomAppBar(
              title: '',
              foreGroundColor: AppColors.whiteColor,
              backGroundColor: AppColors.backGroundColor,
              showBackButton: false,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                children: [
                  Container(
                    height: screenHeight(context) * 0.25,
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'User Profile',
                          style: textThemeData(context).headlineSmall!.copyWith(
                                color: AppColors.blackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                                foregroundColor: AppColors.backGroundColor,
                                backgroundColor: AppColors.backGroundColor,
                                radius: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(9000),
                                  child: Image.network(
                                    UserModel.loggedinUser!.image ??
                                        UserModel.defaultImage,
                                    width: 1000,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor,
                                    border: Border.all(
                                        color: AppColors.blackColor
                                            .withOpacity(0.2))),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          UserModel.loggedinUser!.name ?? "",
                          style: textThemeData(context)
                              .headlineMedium!
                              .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: SettingsCard(
                          text: 'Logout',
                          icon: Icon(
                            Icons.exit_to_app_rounded,
                            color: AppColors.blackColor,
                            size: 24,
                          ),
                          onTap: () {
                            logout();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: SettingsCard(
                          text: 'Edit Profile',
                          icon: Icon(
                            Icons.person,
                            color: AppColors.blackColor,
                            size: 24,
                          ),
                          onTap: () {
                            navigate(context, EditProfileScreen());
                          },
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    showLoadingDialog(context, 'Logging out...');
    await FirebaseAuth.instance.signOut().then((v) {
      UserModel.loggedinUser = null;
      navigateReplaceAll(context, SplashScreen());
    });
  }
}

class SettingsCard extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function onTap;
  const SettingsCard({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                widthSizedBox10,
                Text(
                  text,
                  style: textThemeData(context)
                      .headlineSmall!
                      .copyWith(color: AppColors.blackColor),
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.blackColor,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}
