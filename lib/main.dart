import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/features/settings/controller/settings_controller.dart';
import 'package:sociality/utils/middleware/services.dart';
import 'package:sociality/features/auth/auth_screen.dart';
import 'package:sociality/features/posts/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initial();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: controller.themeMode,
          theme: controller.customLightTheme,
          darkTheme: controller.customDarkTheme,
          home: controller.services.sharedpref.getBool('isLogin') == true
              ? const HomeScreen()
              : const AuthScreen(),
        );
      },
    );
  }
}
