import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void showAlertDialog(String message) {
  Get.defaultDialog(
    title: 'ALERT',
    content: Text(message),
    onConfirm: () => Get.back(),
  );
}
