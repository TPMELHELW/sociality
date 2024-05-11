import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sociality/features/auth/controller/auth_controller.dart';
import 'package:sociality/utils/function/valid_input.dart';
import 'package:sociality/utils/middleware/services.dart';
import 'package:sociality/common/widget/auth_button_widget.dart';
import 'package:sociality/common/widget/text_field_widget.dart';

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
    MyServices myServices = Get.find();
    AuthController controller = Get.put(AuthController());
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
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                : Column(
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
                                validator: (val) =>
                                    validInput(val!, 5, 60, 'email'),
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ButtonWidget(
                        text: isReset
                            ? 'Reset Password'
                            : 'Send Code To Your Email',
                        onpress: () async {
                          isReset
                              ? await controller.resetPassword()
                              : await controller.sendVerifyCode();
                        },
                        isAuth: true,
                        statusRequest: controller.statusRequest,
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
