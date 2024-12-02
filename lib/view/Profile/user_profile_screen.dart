import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';
import 'package:flutter/material.dart';
import '../../utilities/app_colors.dart';
import '../../widgets/custom_appbar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
              showBackButton: true,
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
                              child: Image.asset(
                                AssetsManager.employee,
                                color: AppColors.whiteColor,
                                height: 40,
                              ),
                            ),
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
                          'Abdullah khan',
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
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              // Navigator.pushNamed(
                              //     context, RoutesName.personalDetail);
                              break;

                            case 1:
                              // Navigator.pushNamed(
                              //     context, RoutesName.paymentDetail);
                              break;

                            default:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Scaffold(
                                    body: Center(
                                      child: Text('No routes defined'),
                                    ),
                                  ),
                                ),
                              );
                          }
                        },
                        child: EmployeeDetailContainer(
                          text: '${userProfileDetailText[index]}',
                          imageUrl: '${userProfileIcons[index]}',
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EmployeeDetailContainer extends StatelessWidget {
  final String text;
  final String imageUrl;
  const EmployeeDetailContainer({
    super.key,
    required this.text,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.lightGreyColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                imageUrl,
                color: AppColors.blackColor,
                height: 18,
              ),
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
    );
  }
}
