import 'package:get/get.dart';
import 'package:viral_bites/feature/auth/screen/forget_pass_screen.dart';
import 'package:viral_bites/feature/auth/screen/pass_verify_screen.dart';

import 'package:viral_bites/feature/auth/screen/sign_in_screen.dart';
import 'package:viral_bites/feature/auth/screen/sign_up_screen.dart';
import 'package:viral_bites/feature/auth/screen/sign_up_verify_screen.dart';
import 'package:viral_bites/feature/splash/screen/splash_screen.dart';

class AppRoutes {
  static String init = "/";
  static const signIn = "/sign_in";
  static String signUp = "/sign_up";
  static String signUpVerify = "/sign_up_verify";
  static String forgetPass = "/forget_pass";
  static String passVerify = "/pass_verify";
  static String newPass = "/new_pass";
  static String home = "/home";

  static List<GetPage> routes = [
    GetPage(name: init, page: () => SplashScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: signUpVerify, page: () => SignUpVerifyScreen()),
    GetPage(name: forgetPass, page: () => ForgetPassScreen()),
    GetPage(name: passVerify, page: () => PassVerifyScreen()),
    // GetPage(name: forgetPass, page: () => ForgetPassScreen()),
    // GetPage(name: forgetPass, page: () => ForgetPassScreen()),
  ];
}
