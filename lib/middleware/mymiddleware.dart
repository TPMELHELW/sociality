import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/middleware/middleware.dart';

class MyMiddleware extends GetMiddleware {
    @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedpref.getString("1") == "login") {
      return const RouteSettings(name: '/homescreen');
    }
   
    return null;
  }
}