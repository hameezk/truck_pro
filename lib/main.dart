import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:truck_pro/view/SplashScreen/splash_screen.dart';
import 'firebase_options.dart';
import 'models/user_model.dart';
import 'res/helpers/firebase_helper.dart';
import 'utilities/app_providers.dart';
import 'utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'data/network/check_internet_connectivity.dart';
import 'view/Home/home_screen_admin.dart';
import 'view/Home/home_screen_driver.dart';
import 'view/Home/home_screen_user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNoInternetListener();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelById(currentUser.uid);
    if (thisUserModel != null) {
      UserModel.loggedinUser = thisUserModel;
      runApp(const MyAppLoggedIn());
    }
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppStyles.themeData(),
        home: const SplashScreen(),
      ),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  const MyAppLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppStyles.themeData(),
        home: (UserModel.loggedinUser!.role == 'admin')
            ? const HomeScreenAdmin()
            : (UserModel.loggedinUser!.role == 'driver')
                ? const HomeScreenDriver()
                : const HomeScreenUser(),
      ),
    );
  }
}
