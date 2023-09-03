import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/binding/binding.dart';
import 'package:sociality/test.dart';

import 'view/screen/auth/login.dart';
import 'view/screen/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LogIn(),
      initialBinding: CrudBinding(),
    );
  }
}
