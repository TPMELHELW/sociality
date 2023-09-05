import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/middleware/middleware.dart';

class ThemeController {
  // LogInController controller = Get.find();
  // bool isDark = false;
  MyServices services = Get.find();
  onpress() {
    if (Get.isDarkMode) {
      services.sharedpref.setBool('dark', false);

      Get.changeTheme(customLightTheme);
    } else {
      // isDark = true;
      services.sharedpref.setBool('dark', true);

      Get.changeTheme(customDarkTheme);
    }
  }

  ThemeData customDarkTheme = ThemeData.dark().copyWith(
    // elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: const Color(0xFF242526),
  );
  ThemeData customLightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: const Color(0xFFf6f6f6),
  );
}
