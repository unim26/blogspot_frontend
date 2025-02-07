import 'package:blogspot/features/auth/presentation/pages/change_password_page.dart';
import 'package:blogspot/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:blogspot/features/auth/presentation/pages/login_page.dart';
import 'package:blogspot/features/auth/presentation/pages/on_boarding_page.dart';
import 'package:blogspot/features/auth/presentation/pages/signup_page.dart';
import 'package:blogspot/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:blogspot/features/home/Presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
    //<==============================onboard page route
    'onboardPage': (context) => OnBoardingPage(),

    //<===============================login page route
    'loginPage': (context) => LoginPage(),

    //<=================================signup page route
    'signupPage': (context) => SignupPage(),

    //<==============================forgot password page route
    'forgotPasswordPage': (context) => ForgotPasswordPage(),

    //<=============================otp verification page route
    'otpVerificationPage': (context) {
      final Map<String, String> args = ModalRoute.of(context)?.settings.arguments
          as Map<String, String>; // Fetch the argument
      return VerifyOtpPage(
        routeName: args['routeName'] ?? '',
        email: args['email'] ?? '',
      );
    },

    //change password page route
    'changePasswordPage': (context) {
      final email = ModalRoute.of(context)?.settings.arguments as String;

      return ChangePasswordPage(
        userEmail: email,
      );
    },

    //home page route
    'homePage': (context) => HomePage(),
  };
}
