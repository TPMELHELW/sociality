import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/verifycodedata.dart';

class VerifyCodeController extends GetxController {
  VerifyCodeData getdata = VerifyCodeData(Get.find());

  late StatusRequest statusRequest;

  verificationCode(code) async {
    statusRequest = StatusRequest.loading;
    var responce = await getdata.getData(code);
    statusRequest = handlingData(responce);
    if (statusRequest == StatusRequest.success) {
      if (responce['flag'] != null) {
        Get.offAllNamed('/resetpassword');
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

  @override
  void onInit() {
    statusRequest = StatusRequest.none;
    super.onInit();
  }
}
