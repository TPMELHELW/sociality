import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sociality/core/widget/container_shape_widget.dart';
import 'package:sociality/features/auth/controller/forget_password_controller.dart';
import 'package:sociality/features/auth/screens/forget_password_screen/widgets/forget_form_widget.dart';

class ForgetPassword extends StatelessWidget {
  final bool isReset;
  final bool isVerify;
  const ForgetPassword({
    super.key,
    required this.isReset,
    this.isVerify = false,
  });

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordController controller =
        Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forget Password',
          style: TextStyle(
              fontSize: 30,
              color: Color(0xFF00d5fa),
              fontWeight: FontWeight.bold,
              fontFamily: 'elhelw'),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContainerShapeWidget(
              child: isVerify
                  ? OtpTextField(
                      fieldWidth: 40,
                      numberOfFields: 6,
                      showFieldAsBox: false,
                      borderWidth: 2,
                      borderRadius: BorderRadius.circular(30),
                      onCodeChanged: (String code) {},
                      onSubmit: (String verificationCode) async {
                        await controller.verificationCode(verificationCode);
                      },
                    )
                  : ForgetFormWidget(isReset: isReset)),
        ],
      ),
    );
  }
}
