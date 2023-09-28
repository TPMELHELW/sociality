import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/signupdata.dart';
import 'package:sociality/view/screen/auth/login.dart';

class SignUpController extends GetxController {
  late TextEditingController firstName;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController lastName;
  late TextEditingController location;
  late TextEditingController occupation;

  GlobalKey<FormState> formstate = GlobalKey();
  late StatusRequest statusrequest;

  SignUpData data = SignUpData(Get.find());
  signup() async {
    if (formstate.currentState!.validate()) {
      statusrequest = StatusRequest.loading;
      update();
      Map responce = await data.getData(firstName.text, lastName.text,
          email.text, password.text, location.text, occupation.text);
      statusrequest = handlingData(responce);
      if (statusrequest == StatusRequest.success) {
        if (responce['firstName'] != null) {
          Get.offAll(() => const LogIn());
        } else {
          Get.defaultDialog(
            title: 'ALART',
            content: Text(responce['msg']),
            onConfirm: () => Get.back(),
          );
        }
      } else {
        statusrequest = StatusRequest.serverFailure;
      }
    }
    update();
  }

  @override
  void onInit() {
    email = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    password = TextEditingController();
    location = TextEditingController();
    occupation = TextEditingController();

    statusrequest = StatusRequest.none;
    super.onInit();
  }
}
