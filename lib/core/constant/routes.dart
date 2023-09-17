import 'package:get/get.dart';
import 'package:sociality/middleware/mymiddleware.dart';
import 'package:sociality/view/screen/auth/login.dart';
import 'package:sociality/view/screen/auth/forgetpassword.dart';
import 'package:sociality/view/screen/auth/resetpassword.dart';
import 'package:sociality/view/screen/auth/signup.dart';
import 'package:sociality/view/screen/auth/verifycode.dart';
import 'package:sociality/view/screen/editposts.dart';
import 'package:sociality/view/screen/homescreen.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: '/homescreen', page: () => HomeScreen()),
  GetPage(name: '/', page: () => LogIn(), middlewares: [MyMiddleware()]),
  GetPage(name: '/signup', page: () => SignUp()),
  GetPage(name: '/forgetpassword', page: () => ForgetPassword()),
  GetPage(name: '/verifycode', page: () => VerifyCode()),
  GetPage(name: '/resetpassword', page: () => ResetPassword()),
  // GetPage(name: '/editpost', page: () => EditPost()),
];
