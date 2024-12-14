import 'package:flutter/material.dart';

class BottomNavViewModel extends ChangeNotifier {
  late PageController pageController;
  int _selectBtn = 0;
  int get selectBtn => _selectBtn;

  initilizePageController() {
    pageController = PageController(initialPage: 0);
  }

  changePageIndex(int selectedIndex, {bool animatePage = true}) {
    if (_selectBtn != selectedIndex) {
      _selectBtn = selectedIndex;
      animatePage
          ? pageController.animateToPage(selectBtn,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linearToEaseOut)
          : null;
      notifyListeners();
    }
  }
}
