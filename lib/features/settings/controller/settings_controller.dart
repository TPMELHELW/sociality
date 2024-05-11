import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/utils/class/crud.dart';
import 'package:sociality/utils/class/enum.dart';
import 'package:sociality/utils/function/handlingdata.dart';
import 'package:sociality/utils/data/settingsdata.dart';
import 'package:sociality/utils/middleware/services.dart';

class SettingsController extends GetxController {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController location;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController occupation;
  MyServices myservices = Get.find();

  SettingsData patchdata = SettingsData(Crud());

  late StatusRequest statusRequest;
  updateData() async {
    statusRequest = StatusRequest.loading;
    Map responce = await patchdata.patchData(email.text, location.text,
        occupation.text, password.text, firstName.text, lastName.text);
    statusRequest = handlingData(responce);

    if (statusRequest == StatusRequest.success) {
      if (responce['_id'] != null) {
        myservices.sharedpref.setString("firstname", firstName.text);
        myservices.sharedpref.setString("lastname", lastName.text);
        myservices.sharedpref.setString("email", email.text);
        myservices.sharedpref.setString("location", location.text);
        myservices.sharedpref.setString("occupation", occupation.text);
        Get.offAllNamed('/homescreen');
      }
    }
  }

  MyServices services = Get.find();
  late ThemeMode themeMode;

  void toggleTheme() {
    if (themeMode == ThemeMode.dark) {
      services.sharedpref.setBool("dark", false);

      themeMode = ThemeMode.light;
      update();
    } else {
      services.sharedpref.setBool("dark", true);

      themeMode = ThemeMode.dark;
    }
    update();
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

  @override
  void onInit() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    location = TextEditingController();
    email = TextEditingController();
    occupation = TextEditingController();
    password = TextEditingController();
    firstName.text = '${myservices.sharedpref.getString("firstname")}';
    lastName.text = '${myservices.sharedpref.getString("lastname")}';
    location.text = '${myservices.sharedpref.getString("location")}';
    occupation.text = '${myservices.sharedpref.getString("occupation")}';
    email.text = '${myservices.sharedpref.getString("email")}';
    password.text = '${myservices.sharedpref.getString("password")}';

    statusRequest = StatusRequest.none;
    if (myservices.sharedpref.getBool('dark') == true ||
        Get.isPlatformDarkMode) {
      themeMode = ThemeMode.dark;
      myservices.sharedpref.setBool('dark', true);
    } else {
      themeMode = ThemeMode.light;
      myservices.sharedpref.setBool('dark', false);
    }
    super.onInit();
  }
}
