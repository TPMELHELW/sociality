import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/auth_data.dart';
import 'package:sociality/middleware/middleware.dart';
import 'package:sociality/view/screen/auth/auth_screen.dart';
import 'package:sociality/view/screen/home_screen.dart';

class AuthController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController location;
  late TextEditingController occupation;
  GlobalKey<FormState> formstate = GlobalKey();
  AuthData authData = AuthData(Crud());
  late StatusRequest statusRequest;
  MyServices myservices = Get.find();

  logIn() async {
    try {
      var formData = formstate.currentState!;
      if (formData.validate()) {
        statusRequest = StatusRequest.loading;
        update();
        Map responce = await authData.logInData(email.text, password.text);
        statusRequest = handlingData(responce);
        if (statusRequest == StatusRequest.success) {
          if (responce['user'] != null) {
            myservices.sharedpref.setString("1", "login");
            myservices.sharedpref.setString("token", responce['accessToken']);
            myservices.sharedpref.setString("id", responce['user']['_id']);
            myservices.sharedpref
                .setString("firstname", responce['user']['firstName']);
            myservices.sharedpref
                .setString("lastname", responce['user']['lastName']);
            myservices.sharedpref.setString("email", responce['user']['email']);
            myservices.sharedpref
                .setString("location", responce['user']['location']);
            myservices.sharedpref
                .setString("occupation", responce['user']['occupation']);
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
        } else {
          statusRequest = StatusRequest.failure;
          update();
        }
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
    }
    update();
  }

  signup() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map responce = await authData.signUpData(firstName.text, lastName.text,
          email.text, password.text, location.text, occupation.text);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['firstName'] != null) {
          Get.offAll(() => const AuthScreen(
                isLogin: true,
              ));
        } else {
          Get.defaultDialog(
            title: 'ALART',
            content: Text(responce['msg']),
            onConfirm: () => Get.back(),
          );
        }
      } else {
        statusRequest = StatusRequest.serverFailure;
      }
    }
    update();
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    location = TextEditingController();
    occupation = TextEditingController();
    statusRequest = StatusRequest.none;
    super.onInit();
  }
}
