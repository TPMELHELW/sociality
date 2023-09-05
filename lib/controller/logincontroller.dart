import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/logindata.dart';
import 'package:sociality/middleware/middleware.dart';

import 'package:sociality/view/screen/homescreen.dart';

class LogInController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  

  GlobalKey<FormState> formstate = GlobalKey();

  LogInData data = LogInData(Get.find());
  late StatusRequest statusRequest;
  List<dynamic> inf = [];

  MyServices myservices = Get.find();
  logIn() async {
    try {
      var formData = formstate.currentState!;
      if (formData.validate()) {
        statusRequest = StatusRequest.loading;
        update();
        var responce = await data.getData(email.text, password.text);
        statusRequest = handlingData(responce);
        if (statusRequest == StatusRequest.success) {
          if (responce['user'] != null) {
            inf.add(responce);

            // print(inf[0]['user']['_id']);
            Get.off(() => HomeScreen());
          } else {
            Get.defaultDialog(
              title: 'ALERT',
              content: Text(responce['msg']),
              onConfirm: () => Get.back(),
            );
          }
        } else {
          print('4');
        }
      }
    } catch (e) {
      print(e.toString());
    }
    update();
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    statusRequest = StatusRequest.none;
    super.onInit();
  }
}
