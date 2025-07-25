import 'package:flutter/material.dart';
import 'package:sociality/core/widget/auth_text_button_widget.dart';

class RowButtonWidget extends StatelessWidget {
  final String text, buttonText;
  final void Function()? onpress;
  const RowButtonWidget({
    super.key,
    required this.text,
    required this.buttonText,
    this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        AuthTextButton(text: buttonText, onpress: onpress),
      ],
    );
  }
}

// controller.isLogin
//             ?
//             : "Already have an Account ?"

// !controller.isLogin ? 'Login here' : 'Sign Up here'
// () {
//             controller.isLogin = !controller.isLogin;
//             controller.update();
//           },
