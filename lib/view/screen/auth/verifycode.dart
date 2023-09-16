import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/verifycodecontroller.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Verify Code',
            style: TextStyle(
                fontSize: 30,
                color: Color(0xFF00d5fa),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<VerifyCodeController>(
          init: VerifyCodeController(),
          builder: (controller) => Column(
            children: [
              OtpTextField(
                fieldWidth: 40,
                numberOfFields: 6,
                showFieldAsBox: false,
                borderWidth: 2,
                borderRadius: BorderRadius.circular(30),
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) async {
                  await controller.verificationCode(verificationCode);
                },
              ),
            ],
          ),
        ));
  }
}
