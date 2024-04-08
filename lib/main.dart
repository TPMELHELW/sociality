import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/themedata.dart';
import 'package:sociality/middleware/middleware.dart';
import 'package:sociality/view/screen/auth/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initial();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    ThemeController controller = ThemeController();
    return GetMaterialApp(
      theme: myServices.sharedpref.getBool('dark') == true
          ? controller.customDarkTheme
          : controller.customLightTheme,
      home: const AuthScreen(
        isLogin: true,
      ),
    );
  }
}
