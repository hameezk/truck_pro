import '../../utilities/app_colors.dart';
import '../../utilities/constants.dart';
import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_field.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                title: 'Employees',
                foreGroundColor: AppColors.whiteColor,
                backGroundColor: AppColors.backGroundColor,
                showBackButton: true,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Members',
                          style: textThemeData(context).headlineSmall,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor,
                          ),
                          child: Text(
                            'Add Member',
                            style: textThemeData(context)
                                .headlineSmall!
                                .copyWith(
                                    color: AppColors.blackColor, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    heightSizedBox30,
                    const CustomTextField(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: ListView.builder(
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.userProfileScreen);
                            },
                            child: const EmployeesContainer(),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeesContainer extends StatelessWidget {
  const EmployeesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.blackColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'John Canidy',
            style: textThemeData(context).headlineSmall!.copyWith(fontSize: 14),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: AppColors.whiteColor,
          )
        ],
      ),
    );
  }
}
