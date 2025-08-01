import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/routes/app_pages.dart';
import 'package:sociality/core/services/user_services.dart';
import 'package:sociality/core/theme/theme_data.dart';
import 'package:sociality/features/auth/screens/login_screen/login_screen.dart';
import 'package:sociality/features/posts/home_screen.dart';
import 'package:sociality/utils/middleware/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserService userService = Get.find<UserService>();
    return GetMaterialApp(
      getPages: AppPages().routes,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.customLightTheme,
      darkTheme: AppTheme.customDarkTheme,
      home: userService.currentUser.value == null
          ? const LoginScreen()
          : const HomeScreen(),
    );
  }
}
