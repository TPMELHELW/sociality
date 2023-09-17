import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/verifycodecontroller.dart';
import 'package:sociality/middleware/middleware.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: myServices.sharedpref.getBool('dark') == true
                        ? const Color(0xFF242526)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          offset: Offset(0, 2),
                          blurRadius: 1,
                          spreadRadius: -1),
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.14),
                          offset: Offset(0, 1),
                          blurRadius: 1,
                          spreadRadius: 1),
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.12),
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          spreadRadius: 1)
                    ]),
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(20),
                child: OtpTextField(
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
              )
            ],
          ),
        ));
  }
}
