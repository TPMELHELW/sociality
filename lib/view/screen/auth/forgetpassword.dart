import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/forgetpasswordcontroller.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/validinput.dart';
import 'package:sociality/view/widgets/auth/normalbuttonauth.dart';
import 'package:sociality/view/widgets/auth/textformfield.dart';

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: GetBuilder<ForgetPasswordController>(
        init: ForgetPasswordController(),
        builder: (controller) =>
            controller.statusRequest == StatusRequest.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: controller.formstate,
                          child: TextFormFieldAuth(
                            label: 'Enter Your Email',
                            controller: controller.email,
                            validator: (val) => validInput(val, 5, 60, 'email'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        NormalButtonAuth(
                          text: 'Send Code To Your Email',
                          onpress: () async {
                            await controller.getData();
                          },
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
