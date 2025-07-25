import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/functions/show_dialog.dart';
import 'package:sociality/core/functions/show_snack_bar.dart';
import 'package:sociality/core/routes/app_routes.dart';
import 'package:sociality/features/auth/screens/forget_password_screen/forget_password.dart';
import 'package:sociality/utils/class/crud.dart';
import 'package:sociality/utils/class/enum.dart';
import 'package:sociality/utils/data/auth_data.dart';
import 'package:sociality/utils/function/handlingdata.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get to => Get.find();
  GlobalKey<FormState> formState = GlobalKey();
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmNewpassword;
  bool isReset = false;
  late StatusRequest statusRequest;
  AuthData authData = AuthData(Crud());

  Future<void> resetPassword() async {
    try {
      final form = formState.currentState;
      if (form == null || !form.validate()) return;

      statusRequest = StatusRequest.loading;
      update();

      Map response = await authData.resetPasswordData(password.text);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['msg'] == "Updated Recorded") {
          Get.offNamed(AppRoutes.loginScreen);
          showSnackbar('Success', 'Your password has been reset successfully',
              Colors.green);
        } else {
          showAlertDialog(response['msg']);
        }
      }
    } catch (e) {
      showAlertDialog('An error occurred: $e');
    }
    update();
  }

  Future<void> verificationCode(code) async {
    statusRequest = StatusRequest.loading;
    update();

    Map response = await authData.verifyData(code);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['flag'] != null) {
        Get.offNamed(AppRoutes.resetPasswordScreen);
      } else {
        showAlertDialog(response['msg']);
      }
    }
    update();
  }

  Future<void> sendVerifyCode() async {
    final form = formState.currentState;
    if (form == null || !form.validate()) return;

    statusRequest = StatusRequest.loading;
    update();

    Map response = await authData.forgetPasswordData(email.text);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['msg'] == "you should receive an email") {
        Get.offAll(() => const ForgetPassword(
              isVerify: true,
              isReset: false,
            ));
      } else {
        showAlertDialog(response['msg']);
      }
    }
    update();
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    confirmNewpassword = TextEditingController();
    statusRequest = StatusRequest.none;
    super.onInit();
  }
}
