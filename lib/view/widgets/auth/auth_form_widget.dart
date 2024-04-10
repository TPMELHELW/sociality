import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/auth_controller.dart';
import 'package:sociality/core/function/valid_input.dart';
import 'package:sociality/view/screen/auth/forget_password.dart';
import 'package:sociality/view/widgets/auth/auth_text_button_widget.dart';
import 'package:sociality/view/widgets/auth/auth_text_field_widget.dart';

class AuthFormWidget extends StatelessWidget {
  final bool isLogin;
  final AuthController controller;
  const AuthFormWidget(
      {super.key, required this.isLogin, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formstate,
      child: Column(
        children: [
          !isLogin
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormFieldAuth(
                            controller: controller.firstName,
                            label: 'First Name',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormFieldAuth(
                            controller: controller.lastName,
                            label: 'Last Name',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormFieldAuth(
                      controller: controller.location,
                      label: 'Location',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormFieldAuth(
                      controller: controller.occupation,
                      label: 'Ocuupation',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : const SizedBox(),
          TextFormFieldAuth(
            controller: controller.email,
            label: 'Email',
            validator: (val) => validInput(val!, 1, 40, 'email'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormFieldAuth(
            controller: controller.password,
            label: 'Password',
          ),
          isLogin
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
          )
        ],
      ),
    );
  }
}
