import 'package:flutter/material.dart';

class TextAppBar extends StatelessWidget {
  final String text;
  const TextAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 30,
        color: Color(0xFF00d5fa),
        fontWeight: FontWeight.bold,
        fontFamily: 'elhelw',
      ),
    );
  }
}
