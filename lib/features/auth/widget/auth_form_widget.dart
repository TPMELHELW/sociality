import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/common/widget/auth_button_widget.dart';
import 'package:sociality/features/auth/controller/auth_controller.dart';
import 'package:sociality/utils/function/valid_input.dart';
import 'package:sociality/features/auth/forget_password.dart';
import 'package:sociality/features/auth/widget/auth_text_button_widget.dart';
import 'package:sociality/common/widget/text_field_widget.dart';

class AuthFormWidget extends StatelessWidget {
  final AuthController controller;
  const AuthFormWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formState,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          !controller.isLogin
              ? Column(
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
                )
              : const SizedBox(),
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
          controller.isLogin
              ? AuthTextButton(
                  text: 'Forget Passowrd?',
                  onpress: () {
                    Get.delete<AuthController>();
                    Get.to(() => const ForgetPassword(
                          isReset: false,
                        ));
                  },
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          ButtonWidget(
            isAuth: true,
            statusRequest: controller.statusRequest,
            text: controller.isLogin ? 'LogIn' : 'SignUp',
            onpress: () => controller.onAuthButtonTap(),
          ),
        ],
      ),
    );
  }
}
