import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/settingsdata.dart';
import 'package:sociality/middleware/middleware.dart';

class SettingsController extends GetxController {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController location;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController occupation;
  MyServices myservices = Get.find();

  SettingsData patchdata = SettingsData(Get.find());

  late StatusRequest statusRequest;
  updateData() async {
    statusRequest = StatusRequest.loading;
    Map responce = await patchdata.patchData({
      'Authorization': 'Bearer ${myservices.sharedpref.getString('token')}',
    }, email.text, location.text, occupation.text, password.text,
        firstName.text, lastName.text);
    statusRequest = handlingData(responce);

    if (statusRequest == StatusRequest.success) {
      if (responce['_id'] != null) {
        myservices.sharedpref.setString("firstname", firstName.text);
        myservices.sharedpref.setString("lastname", lastName.text);
        myservices.sharedpref.setString("email", email.text);
        myservices.sharedpref.setString("location", location.text);
        myservices.sharedpref.setString("occupation", occupation.text);
        Get.offAllNamed('/homescreen');
      }
    }
  }

  @override
  void onInit() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    location = TextEditingController();
    email = TextEditingController();
    occupation = TextEditingController();
    password = TextEditingController();
    firstName.text = '${myservices.sharedpref.getString("firstname")}';
    lastName.text = '${myservices.sharedpref.getString("lastname")}';
    location.text = '${myservices.sharedpref.getString("location")}';
    occupation.text = '${myservices.sharedpref.getString("occupation")}';
    email.text = '${myservices.sharedpref.getString("email")}';
    password.text = '${myservices.sharedpref.getString("password")}';

    statusRequest = StatusRequest.none;
    super.onInit();
  }
}
