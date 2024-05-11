import 'package:flutter/material.dart';
import 'package:sociality/features/auth/controller/auth_controller.dart';
import 'package:sociality/features/auth/widget/auth_text_button_widget.dart';

class AuthBottomWidget extends StatelessWidget {
  final AuthController controller;
  const AuthBottomWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(controller.isLogin
            ? "Don't have an account ?"
            : "Already have an Account ?"),
        AuthTextButton(
          text: !controller.isLogin ? 'Login here' : 'Sign Up here',
          onpress: () {
            controller.isLogin = !controller.isLogin;
            controller.update();
          },
        ),
      ],
    );
  }
}
