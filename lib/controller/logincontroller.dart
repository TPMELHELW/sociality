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
        Map responce = await data.getData(email.text, password.text);
        statusRequest = handlingData(responce);
        if (statusRequest == StatusRequest.success) {
          if (responce['user'] != null) {
            inf.clear();
            inf.add(responce);
            myservices.sharedpref.setString("1", "login");
            myservices.sharedpref.setString("token", inf[0]['accessToken']);
            myservices.sharedpref.setString("id", inf[0]['user']['_id']);
            myservices.sharedpref
                .setString("firstname", inf[0]['user']['firstName']);
            myservices.sharedpref
                .setString("lastname", inf[0]['user']['lastName']);
            myservices.sharedpref.setString("email", inf[0]['user']['email']);
            myservices.sharedpref
                .setString("location", inf[0]['user']['location']);
            myservices.sharedpref
                .setString("occupation", inf[0]['user']['occupation']);
            email.clear();
            password.clear();
            Get.offAll(() => const HomeScreen());
          } else {
            Get.defaultDialog(
              title: 'ALERT',
              content: Text(responce['msg']),
              onConfirm: () => Get.back(),
            );
          }
        } else {}
      }
    } catch (e) {}
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
