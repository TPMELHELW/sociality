import 'package:flutter/material.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final void Function()? onpress;
  const AuthTextButton({super.key, required this.text, this.onpress});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpress,
      child: Text(text),
    );
  }
}
