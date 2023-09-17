import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/forgetpassword.dart';
import 'package:sociality/data/resetpassworddata.dart';

class ResetPasswordController extends GetxController {
  late TextEditingController newpassword;
  late TextEditingController confirmNewpassword;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  ResetPasswordData getdata = ResetPasswordData(Get.find());
  late StatusRequest statusRequest;

  patchData() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var responce = await getdata.patchData(newpassword.text);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['msg'] == "Updated Recorded") {
          Get.offAllNamed('/login');
        } else {
          // print('2');
          Get.defaultDialog(
            title: 'ALART',
            content: Text(responce['msg']),
            onConfirm: () => Get.back(),
          );
        }
      }else{
        print({1});
      }
      update();
    }
  }

  @override
  void onInit() {
    newpassword = TextEditingController();
    confirmNewpassword = TextEditingController();
    statusRequest = StatusRequest.none;
    super.onInit();
  }
}
