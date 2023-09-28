import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/forgetpassword.dart';

class ForgetPasswordController extends GetxController {
  ForgetPassword getdata = ForgetPassword(Get.find());
  late TextEditingController email;
  late StatusRequest statusRequest;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  getData() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map responce = await getdata.getData(email.text);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['msg'] == "you should receive an email") {
          Get.offAllNamed('/verifycode');
        } else {
          Get.defaultDialog(
            title: 'ALART',
            content: Text(responce['msg']),
            onConfirm: () => Get.back(),
          );
        }
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    statusRequest = StatusRequest.none;
  }
}
