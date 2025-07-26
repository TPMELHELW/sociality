import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/routes/app_routes.dart';
import 'package:sociality/core/widget/auth_button_widget.dart';
import 'package:sociality/features/auth/controller/login_controller.dart';
import 'package:sociality/core/widget/auth_text_button_widget.dart';
import 'package:sociality/utils/function/valid_input.dart';
import 'package:sociality/core/widget/text_field_widget.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = LoginController.instance;
    return Form(
      key: controller.formState,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          AuthTextButton(
              text: 'Forget Passowrd?',
              onpress: () => Get.toNamed(AppRoutes.forgetPasswordScreen)),
          ButtonWidget(
            statusRequest: controller.statusRequest,
            text: 'LogIn',
            onpress: () => controller.logIn(),
          ),
        ],
      ),
    );
  }
}
