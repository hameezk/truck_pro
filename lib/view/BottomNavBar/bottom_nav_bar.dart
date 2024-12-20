// ignore_for_file: deprecated_member_use, sort_child_properties_last, must_be_immutable

import 'package:truck_pro/view/Home/home_screen_driver.dart';
import 'package:truck_pro/view/Home/home_screen_user.dart';
import 'package:truck_pro/view/Settings/settings_screen.dart';
import '../../utilities/app_colors.dart';
import '../../viewmodel/bottom_nav_view_model.dart';
import '../../widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Chats/chats.dart';
import '../Home/home_screen_admin.dart';
import '../Orders/orders.dart';
import '../Orders/orders_admin.dart';
import '../Orders/orders_driver.dart';

class BottomNavBarScreen extends StatefulWidget {
  int initialIndex;
  String role;
  BottomNavBarScreen(
      {super.key, required this.initialIndex, required this.role});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  late BottomNavViewModel bottomNavViewModel;
  List<Widget> adminScreens = [
    HomeScreenAdmin(),
    ChatPage(),
    MyOrdersAdmin(),
    SettingsScreen(),
  ];
  List<Widget> userScreens = [
    HomeScreenUser(),
    ChatPage(),
    MyOrders(),
    SettingsScreen(),
  ];
  List<Widget> driverScreens = [
    HomeScreenDriver(),
    ChatPage(),
    MyOrdersDriver(),
    SettingsScreen(),
  ];
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
            physics: PageScrollPhysics(),
            controller: bottomNavViewModel.pageController,
            onPageChanged: (value) {
              bottomNavViewModel.changePageIndex(value, animatePage: false);
            },
            children: (widget.role == 'admin')
                ? adminScreens
                : (widget.role == 'driver')
                    ? driverScreens
                    : userScreens,
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
