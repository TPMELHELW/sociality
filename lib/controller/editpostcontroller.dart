import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/editpostdata.dart';
import 'package:sociality/middleware/middleware.dart';

class EditPostController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey();

  late TextEditingController description;
  String? desc;

  EditPostData getdata = EditPostData(Get.find());
  late StatusRequest statusrequest;
  MyServices myservices = Get.find();
  editPost(postId) async {
    if (formState.currentState!.validate()) {
      statusrequest = StatusRequest.loading;
      update();
      var responce = await getdata.patchData(postId, desc, {
        'Authorization': 'Bearer ${myservices.sharedpref.getString('token')}'
      });
      statusrequest = handlingData(responce);
      if (statusrequest == StatusRequest.success) {
        if (responce['description'] != null) {
          Get.offAllNamed('/homescreen');
        } else {
          Get.defaultDialog(
            title: 'ALERT',
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
    statusrequest = StatusRequest.none;
    description = TextEditingController();
  }
}
