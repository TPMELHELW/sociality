import 'package:flutter/material.dart';

class TextButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onpress;
  const TextButtonAuth({super.key, required this.text, this.onpress});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpress,
      child: Text(text),
    );
  }
}
