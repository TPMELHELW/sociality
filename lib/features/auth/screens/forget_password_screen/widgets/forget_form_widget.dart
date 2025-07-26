import 'package:flutter/material.dart';
import 'package:sociality/core/widget/auth_button_widget.dart';
import 'package:sociality/core/widget/text_field_widget.dart';
import 'package:sociality/features/auth/controller/forget_password_controller.dart';
import 'package:sociality/utils/function/valid_input.dart';

class ForgetFormWidget extends StatelessWidget {
  final bool isReset;
  const ForgetFormWidget({super.key, required this.isReset});

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordController controller = ForgetPasswordController.to;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: controller.formState,
          child: isReset
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFieldWidget(
                      label: 'Enter New Password',
                      controller: controller.password,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Confirm Password',
                      controller: controller.confirmNewpassword,
                      validator: (val) {
                        if (controller.password.text != val) {
                          return 'error';
                        }
                        return null;
                      },
                    ),
                  ],
                )
              : TextFieldWidget(
                  label: 'Enter Your Email',
                  controller: controller.email,
                  validator: (val) => validInput(val!, 5, 60, 'email'),
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        ButtonWidget(
          text: isReset ? 'Reset Password' : 'Send Code To Your Email',
          onpress: () async {
            isReset
                ? await controller.resetPassword()
                : await controller.sendVerifyCode();
          },
          statusRequest: controller.statusRequest,
        )
      ],
    );
  }
}
