import 'package:flutter/material.dart';

class DescribtionField extends StatelessWidget {
  final Key? global;
  final TextEditingController controller;
  final String text;
  const DescribtionField({super.key, this.global, required this.controller, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Form(
        key: global,
        child: TextFormField(
          controller:controller,
          decoration: InputDecoration(
            hintText:
                text,
            fillColor: const Color(0xFF333333),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}
