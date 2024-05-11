import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/utils/class/crud.dart';
import 'package:sociality/utils/class/enum.dart';
import 'package:sociality/utils/function/handlingdata.dart';
import 'package:sociality/utils/data/auth_data.dart';
import 'package:sociality/utils/middleware/services.dart';
import 'package:sociality/features/auth/forget_password.dart';
import 'package:sociality/features/posts/home_screen.dart';

class AuthController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController location;
  late TextEditingController occupation;
  late TextEditingController confirmNewpassword;
  GlobalKey<FormState> formState = GlobalKey();
  bool isLogin = true;
  AuthData authData = AuthData(Crud());
  late StatusRequest statusRequest;
  MyServices myservices = Get.find();

  Future<void> resetPassword() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map responce = await authData.resetPasswordData(password.text);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['msg'] == "Updated Recorded") {
          isLogin = true;
          update();
        } else {
          Get.defaultDialog(
            title: 'ALART',
            content: Text(responce['msg']),
            onConfirm: () => Get.back(),
          );
        }
      } else {}
      update();
    }
  }

  Future<void> logIn() async {
    try {
      var formData = formState.currentState!;
      if (formData.validate()) {
        statusRequest = StatusRequest.loading;
        update();
        Map responce = await authData.logInData(email.text, password.text);
        statusRequest = handlingData(responce);
        if (statusRequest == StatusRequest.success) {
          if (responce['user'] != null) {
            myservices.sharedpref.setBool('isLogin', true);
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

  Future<void> signup() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map responce = await authData.signUpData(firstName.text, lastName.text,
          email.text, password.text, location.text, occupation.text);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['firstName'] != null) {
          isLogin = true;
          update();
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

  Future sendVerifyCode() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map responce = await authData.forgetPasswordData(email.text);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['msg'] == "you should receive an email") {
          Get.offAll(() => const ForgetPassword(
                isVerify: true,
                isReset: false,
              ));
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

  Future<void> verificationCode(code) async {
    statusRequest = StatusRequest.loading;
    Map responce = await authData.verifyData(code);
    statusRequest = handlingData(responce);
    if (statusRequest == StatusRequest.success) {
      if (responce['flag'] != null) {
        Get.offAll(() => const ForgetPassword(
              isReset: true,
            ));
      } else {
        Get.defaultDialog(
          title: 'ALART',
          content: Text(responce['msg']),
          onConfirm: () => Get.back(),
        );
      }
    }
    update();
  }

  void onAuthButtonTap() async {
    isLogin ? await logIn() : await signup();
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
    confirmNewpassword = TextEditingController();
    statusRequest = StatusRequest.none;
    super.onInit();
  }
}
