import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/widget/auth_button_widget.dart';
import 'package:sociality/features/auth/controller/signup_controller.dart';
import 'package:sociality/utils/function/valid_input.dart';
import 'package:sociality/core/widget/text_field_widget.dart';

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());
    return Form(
      key: controller.formState,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: controller.firstName,
                      label: 'First Name',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFieldWidget(
                      controller: controller.lastName,
                      label: 'Last Name',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                controller: controller.location,
                label: 'Location',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                controller: controller.occupation,
                label: 'Ocuupation',
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          TextFieldWidget(
            controller: controller.email,
            label: 'Email',
            validator: (val) => validInput(val!, 1, 40, 'email'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            controller: controller.password,
            label: 'Password',
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonWidget(
            statusRequest: controller.statusRequest,
            text: 'SignUp',
            onpress: () => controller.signup(),
          ),
        ],
      ),
    );
  }
}
