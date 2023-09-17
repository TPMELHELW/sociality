import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/binding/binding.dart';
import 'package:sociality/controller/themedata.dart';
import 'package:sociality/core/constant/routes.dart';
import 'package:sociality/middleware/middleware.dart';
import 'view/screen/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initial();
  runApp(MyApp());
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
      initialBinding: CrudBinding(),
      getPages: routes,
    );
  }
}
