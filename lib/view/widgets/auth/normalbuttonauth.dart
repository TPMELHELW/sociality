import 'package:flutter/material.dart';

class NormalButtonAuth extends StatelessWidget {
  final void Function()? onpress;
  final String text;
  const NormalButtonAuth({super.key, this.onpress, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(50, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text),
    );
  }
}
