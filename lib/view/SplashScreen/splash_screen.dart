// ignore_for_file: avoid_unnecessary_containers

import 'package:truck_pro/methods/navigate.dart';
import 'package:truck_pro/utilities/screen_sizes.dart';
import 'package:truck_pro/view/Login/login_screen.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward().whenComplete(() {
      navigate(context, const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Container(
          child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: animation.value,
                  child: Image.asset(
                    AssetsManager.logo,
                    height: screenHeight(context) * 0.8,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
