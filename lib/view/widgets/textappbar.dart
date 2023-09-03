import 'package:flutter/material.dart';

class TextAppBar extends StatelessWidget {
  const TextAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sociality',
      style: TextStyle(
          fontSize: 30, color: Color(0xFF00d5fa), fontWeight: FontWeight.bold),
    );
  }
}
