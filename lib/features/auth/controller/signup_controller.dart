import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/services/shared_preferences_services.dart';
import 'package:sociality/core/services/user_services.dart';
import 'package:sociality/utils/class/crud.dart';
import 'package:sociality/utils/class/enum.dart';
import 'package:sociality/utils/data/auth_data.dart';
import 'package:sociality/utils/function/handlingdata.dart';

class SignupController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController location;
  late TextEditingController occupation;
  late TextEditingController confirmNewpassword;
  GlobalKey<FormState> formState = GlobalKey();
  AuthData authData = AuthData(Crud());
  final UserService userService = Get.find<UserService>();
  final SharedPreferencesService sharedPreferencesService =
      Get.find<SharedPreferencesService>();

  late StatusRequest statusRequest;

  Future<void> signup() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map responce = await authData.signUpData(firstName.text, lastName.text,
          email.text, password.text, location.text, occupation.text);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['firstName'] != null) {
          // isLogin = true;
          // update();
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
    confirmNewpassword = TextEditingController();
    statusRequest = StatusRequest.none;
    super.onInit();
  }
}
