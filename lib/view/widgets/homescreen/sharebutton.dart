import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final void Function()? onpress;
  const ShareButton({super.key, this.onpress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(50, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text('Share'),
    );
  }
}
