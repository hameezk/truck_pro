import 'package:truck_pro/models/user_model.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../Login/login_screen.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    nameController.text = UserModel.loggedinUser!.name ?? "";
    emailController.text = UserModel.loggedinUser!.email ?? "";
    phonenoController.text = UserModel.loggedinUser!.phoneno ?? "";
    super.initState();
  }

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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showImageOptions(context, setState);
                            },
                            child: Stack(
                              children: [
                                CircleAvatar(
                                    foregroundColor: AppColors.backGroundColor,
                                    backgroundColor: AppColors.backGroundColor,
                                    radius: 60,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(9000),
                                      child: (imageFile != null)
                                          ? Image.file(
                                              imageFile!,
                                              fit: BoxFit.cover,
                                              width: 4000,
                                            )
                                          : Image.network(
                                              UserModel.loggedinUser!.image ??
                                                  UserModel.defaultImage,
                                              fit: BoxFit.cover),
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            readOnly: true,
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
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              checkValues(context);
                            },
                            child: const CustomButton(
                                buttonText: 'Update Profile'),
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
