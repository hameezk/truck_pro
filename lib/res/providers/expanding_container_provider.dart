import 'package:flutter/foundation.dart';

class AttendanceContainerProvider extends ChangeNotifier {
  List<bool> _expandedState = [];

  AttendanceContainerProvider() {
    _expandedState = List.generate(10, (index) => false);
  }
  bool isExpanded(int index) {
    return _expandedState[index];
  }

  setContainerState(int index) {
    _expandedState[index] = !_expandedState[index];
    notifyListeners();
  }
}
