import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/infinitiscrollcontroller.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/sharepostsdata.dart';

class SharePostsController extends GetxController {
  late TextEditingController description;
  GlobalKey<FormState> formState = GlobalKey();
  bool isMore = false;
  SharePostsData data = SharePostsData(Get.find());
  late StatusRequest statusrequest;
  LogInController controller = Get.find();
  Scroll controller0 = Get.put(Scroll());
  postData() async {
    if (formState.currentState!.validate()) {
      statusrequest = StatusRequest.loading;
      var responce = await data.postData(description.text,
          {'Authorization': 'Bearer ${controller.inf[0]['accessToken']}'});
      statusrequest = handlingData(responce);

      if (statusrequest == StatusRequest.success) {
        if (responce['userId'] != null) {
          description.clear();
        } else {}
      } else {}
    }
  }

  @override
  void onInit() {
    description = TextEditingController();
    super.onInit();
  }
}
