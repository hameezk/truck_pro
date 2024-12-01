import '../utilities/app_colors.dart';
import '../viewmodel/bottom_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/bottom_nav_model.dart';

Widget navigationBar() {
  return Consumer<BottomNavViewModel>(
    builder: (context, bottomNavState, child) {
      return AnimatedContainer(
        height: 60.0,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          borderRadius: BorderRadius.only(
            topLeft:
                Radius.circular(bottomNavState.selectBtn == 0 ? 0.0 : 20.0),
            topRight: Radius.circular(
                bottomNavState.selectBtn == navigationBarButtons.length - 1
                    ? 0.0
                    : 20.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: navigationBarButtons
              .map(
                (button) => GestureDetector(
                  onTap: () => bottomNavState.changePageIndex(
                    navigationBarButtons.indexOf(button),
                  ),
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: iconBtn(
                          navigationBarButtons.indexOf(button), context),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    },
  );
}

SizedBox iconBtn(int buttonIndex, context) {
  BottomNavViewModel bottomNavViewModel =
      Provider.of<BottomNavViewModel>(context, listen: false);
  bool isActive = bottomNavViewModel.selectBtn == buttonIndex;
  var height = isActive ? 100.0 : 0.0;
  var width = isActive ? 100.0 : 0.0;
  return SizedBox(
    width: 75.0,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: AnimatedContainer(
            height: height,
            width: width,
            duration: const Duration(milliseconds: 400),
            child: isActive
                ? CustomPaint(
                    painter: ButtonNotch(),
                  )
                : const SizedBox(),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.only(bottom: isActive ? 40.0 : 10),
            child: Image.asset(
              navigationBarButtons[buttonIndex].imagePath,
              color: isActive ? AppColors.primaryColor : AppColors.primaryColor,
              height: 20,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.only(bottom: isActive ? 0 : 4),
            child: Text(
              isActive ? "•" : navigationBarButtons[buttonIndex].name,
              style: TextStyle(
                color:
                    isActive ? AppColors.primaryColor : AppColors.primaryColor,
                fontWeight: isActive ? FontWeight.w900 : null,
                fontSize: isActive ? 30 : 12,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class ButtonNotch extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // The center point of the notch circle
    // var dotPoint = Offset(size.width / 2, 2);

    // Paint for the background notch color
    var paint_1 = Paint()
      ..color = AppColors.blackColor
      ..style = PaintingStyle.fill;

    // Paint for the inner circle (notch circle)
    // var paint_2 = Paint()
    //   ..color = Colors.white
    //   ..style = PaintingStyle.fill;

    // Path for the notch
    var path = Path();

    // Start the path from the left edge
    path.moveTo(0, 0);

    // Left curve, keep this shorter and pointy
    path.quadraticBezierTo(
      size.width * 0.15, 0, // Control point for smooth transition
      size.width * 0.15, 8, // Extend the notch length to 25% of width
    );

    // Middle deep curve, making it deeper and wider
    path.quadraticBezierTo(
      size.width / 2, size.height * 1.1, // Control point for deeper curve
      size.width * 0.85, 8, // End the deep curve towards 75% of the width
    );

    // Right curve, mirror the left side
    path.quadraticBezierTo(
      size.width * 0.85, 0, // Control point to smooth out
      size.width, 0, // End point at the right edge
    );

    // Close the path to complete the shape
    path.close();

    // Draw the path (the notch background)
    canvas.drawPath(path, paint_1);

    // Draw the circle in the middle of the notch
    //canvas.drawCircle(dotPoint, 6, paint_2); // Adjust size as needed for the icon
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
