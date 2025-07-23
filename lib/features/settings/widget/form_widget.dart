import 'package:flutter/material.dart';
import 'package:sociality/core/widget/text_field_widget.dart';
import 'package:sociality/features/settings/controller/settings_controller.dart';
import 'package:sociality/features/settings/data/fields_data.dart';

class FormWidget extends StatelessWidget {
  final SettingsController controller;
  const FormWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFieldWidget(
                  controller: controller.firstName,
                  label: 'First Name',
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextFieldWidget(
                  controller: controller.lastName,
                  label: 'Last Name',
                ),
              )
            ],
          ),
          ...List.generate(
            fields.length,
            (index) => TextFieldWidget(
              label: fields[index],
              controller: fieldsController[index],
            ),
          )
        ],
      ),
    );
  }
}
