import 'package:flutter/material.dart';

class TextFormFieldAuth extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const TextFormFieldAuth({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
