import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/forgetpasswordcontroller.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/validinput.dart';
import 'package:sociality/middleware/middleware.dart';
import 'package:sociality/view/widgets/auth/normalbuttonauth.dart';
import 'package:sociality/view/widgets/auth/textformfield.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
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
        builder: (controller) => controller.statusRequest ==
                StatusRequest.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                ],
              ),
      ),
    );
  }
}
