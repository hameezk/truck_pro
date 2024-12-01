import 'routes_name.dart';
import '../view/Calender/show_calender_screen.dart';
import '../view/InVoice/invoice_screen.dart';
import '../view/Login/login_screen.dart';
import '../view/OTP/otp_screen.dart';
import '../view/Payment%20detail/payment_detail.dart';
import '../view/Personal%20Detail/personal_detail.dart';
import '../view/Register/register_screen.dart';
import '../view/ResetPassword/reset_password_screen.dart';
import '../view/SplashScreen/splash_screen.dart';
import '../view/TranscationHistory/transcation_history_screen.dart';
import '../view/Transfer/transfer_screen.dart';
import 'package:flutter/material.dart';
import '../view/Profile/user_profile_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RoutesName.loginPage:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case RoutesName.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());

      case RoutesName.resetPassword:
        return MaterialPageRoute(
            builder: (context) => const ResetPasswordScreen());

      case RoutesName.otpScreen:
        return MaterialPageRoute(builder: (context) => const OTPScreen());

      case RoutesName.userProfileScreen:
        return MaterialPageRoute(
            builder: (context) => const UserProfileScreen());

      case RoutesName.personalDetail:
        return MaterialPageRoute(
            builder: (context) => const PersonalDetailScreen());

      case RoutesName.paymentDetail:
        return MaterialPageRoute(
            builder: (context) => const PaymentDetailScreen());
      case RoutesName.showCalenderScreen:
        return MaterialPageRoute(
            builder: (context) => const ShowCalenderScreen());
      case RoutesName.transcationHistory:
        return MaterialPageRoute(
            builder: (context) => const TranscationHistoryScreen());
      case RoutesName.transferScreen:
        return MaterialPageRoute(builder: (context) => const TransferScreen());

      case RoutesName.inVoice:
        return MaterialPageRoute(builder: (context) => const InvoiceScreen());

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No Route defined'),
            ),
          ),
        );
    }
  }
}
