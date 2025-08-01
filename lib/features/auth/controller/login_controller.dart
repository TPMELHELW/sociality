import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/functions/show_dialog.dart';
import 'package:sociality/core/services/shared_preferences_services.dart';
import 'package:sociality/core/services/user_services.dart';
import 'package:sociality/features/posts/home_screen.dart';
import 'package:sociality/utils/class/crud.dart';
import 'package:sociality/utils/class/enum.dart';
import 'package:sociality/utils/data/auth_data.dart';
import 'package:sociality/utils/function/handlingdata.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find<LoginController>();

  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> formState = GlobalKey();
  late StatusRequest statusRequest;
  AuthData authData = AuthData(Crud());
  final UserService userService = Get.find<UserService>();
  final SharedPreferencesService sharedPreferencesService =
      Get.find<SharedPreferencesService>();

  Future<void> logIn() async {
    final form = formState.currentState;
    if (form == null) return;
    if (!form.validate()) return;

    statusRequest = StatusRequest.loading;
    update();

    try {
      Map response = await authData.logInData(email.text, password.text);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['user'] != null) {
          await userService.saveUser(response);
          sharedPreferencesService.setBool('isLogin', true);
          Get.offAll(() => const HomeScreen());
        } else {
          showAlertDialog(response['msg']);
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      showAlertDialog('An error occurred. Please try again : ${e.toString()}');
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
