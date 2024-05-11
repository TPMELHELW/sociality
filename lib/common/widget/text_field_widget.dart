import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onchanged;
  const TextFieldWidget(
      {super.key,
      required this.label,
      required this.controller,
      this.validator,
      this.onchanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onchanged,
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
