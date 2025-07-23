import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/features/auth/controller/auth_controller.dart';
import 'package:sociality/features/posts/controller/home_screen_controller.dart';
import 'package:sociality/utils/class/enum.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onpress;
  final String text;
  final bool isAuth;
  final StatusRequest statusRequest;
  const ButtonWidget(
      {super.key,
      this.onpress,
      required this.text,
      required this.isAuth,
      required this.statusRequest});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: isAuth ? AuthController() : HomeScreenController(),
        builder: (controller) {
          return ElevatedButton(
            onPressed: onpress,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(50, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: statusRequest == StatusRequest.loading
                ? const Center(child: CircularProgressIndicator())
                : Text(text),
          );
        });
  }
}
