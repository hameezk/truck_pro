import '../res/providers/expanding_container_provider.dart';
import '../viewmodel/bottom_nav_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (context) => BottomNavViewModel()),
  ChangeNotifierProvider(create: (context) => AttendanceContainerProvider()),
];
