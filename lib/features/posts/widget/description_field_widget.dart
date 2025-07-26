import 'package:flutter/material.dart';
import 'package:sociality/features/posts/controller/home_screen_controller.dart';

class DescribtionField extends StatelessWidget {
  const DescribtionField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = HomeScreenController.to;
    return Expanded(
      flex: 3,
      child: Form(
        key: controller.formState,
        child: TextFormField(
          controller: controller.descriptionController,
          decoration: InputDecoration(
            hintText: "What`s on your mind ..",
            fillColor: Colors.black,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
