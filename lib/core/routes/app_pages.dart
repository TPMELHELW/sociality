import 'package:get/get.dart';
import 'package:sociality/core/routes/app_routes.dart';
import 'package:sociality/features/auth/screens/forget_password_screen/forget_password.dart';
import 'package:sociality/features/auth/screens/login_screen/login_screen.dart';
import 'package:sociality/features/auth/screens/signup_screen/signup_screen.dart';
import 'package:sociality/features/posts/home_screen.dart';
import 'package:sociality/features/profile/screens/profile_screen.dart';

class AppPages {
  List<GetPage> routes = [
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.signupScreen,
      page: () => const SignupScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.forgetPasswordScreen,
      page: () => const ForgetPassword(isReset: false),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.resetPasswordScreen,
      page: () => const ForgetPassword(isReset: true),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => const ProfileScreen(),
      transition: Transition.cupertino,
    ),
  ];
}
