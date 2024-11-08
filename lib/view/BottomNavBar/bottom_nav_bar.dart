// ignore_for_file: deprecated_member_use, sort_child_properties_last, must_be_immutable

import '../../utilities/app_colors.dart';
import '../Account/account_screen.dart';
import '../PayRoll/payroll_screen.dart';
import '../Home/home_screen_admin.dart';
import '../Manage/management_screen.dart';
import '../../viewmodel/bottom_nav_view_model.dart';
import '../../widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBarScreen extends StatefulWidget {
  int initialIndex;
  BottomNavBarScreen({super.key, required this.initialIndex});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  late BottomNavViewModel bottomNavViewModel;
  @override
  void initState() {
    initStateFunctions(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backGroundColor,
      body: WillPopScope(
        onWillPop: () async {
          if (bottomNavViewModel.selectBtn != 0) {
            return bottomNavViewModel.changePageIndex(0);
          }
          return true;
        },
        child: SafeArea(
          bottom: false,
          child: PageView(
            controller: bottomNavViewModel.pageController,
            onPageChanged: (value) {
              bottomNavViewModel.changePageIndex(value, animatePage: false);
            },
            children: const [
              HomeScreenAdmin(),
              ManagementScreen(),
              PayRollScreen(),
              AccountScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: navigationBar(),
    );
  }

  void initStateFunctions(BuildContext context) {
    bottomNavViewModel =
        Provider.of<BottomNavViewModel>(context, listen: false);
    bottomNavViewModel.initilizePageController();
  }
}
