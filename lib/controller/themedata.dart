import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sociality/middleware/middleware.dart';

class ThemeController {
  MyServices services = Get.find();
  onpress() {
    if (Get.isDarkMode) {
      services.sharedpref.setBool('dark', false);

      Get.changeTheme(customLightTheme);
    } else {
      services.sharedpref.setBool('dark', true);

      Get.changeTheme(customDarkTheme);
    }
  }

  ThemeData customDarkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: const Color(0xFF0a0a0a),
   
  );
  ThemeData customLightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: const Color(0xFFf6f6f6),
  );
}
