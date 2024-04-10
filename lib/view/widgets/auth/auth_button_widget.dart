import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/auth_controller.dart';
import 'package:sociality/core/class/enum.dart';

class AuthButtonWidget extends StatelessWidget {
  final void Function()? onpress;
  final String text;
  const AuthButtonWidget({super.key, this.onpress, required this.text});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(50, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: controller.statusRequest == StatusRequest.loading
            ? const Center(child: CircularProgressIndicator())
            : Text(text),
      );
    });
  }
}
