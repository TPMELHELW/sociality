import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String title, String message, Color backgroundColor) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    colorText: Colors.white,
  );
}
