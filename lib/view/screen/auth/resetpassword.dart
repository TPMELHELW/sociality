import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/reset_password_controller.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/middleware/middleware.dart';
import 'package:sociality/view/widgets/auth/normalbuttonauth.dart';
import 'package:sociality/view/widgets/auth/auth_text_field_widget.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: const TextAppBar(text: 'ResetPassword'),
          elevation: 0,
          centerTitle: true,
        ),
        body: GetBuilder<ResetPasswordController>(
          init: ResetPasswordController(),
          builder: (controller) => controller.statusRequest ==
                  StatusRequest.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        child: Form(
                          key: controller.formstate,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormFieldAuth(
                                label: 'Enter New Password',
                                controller: controller.newpassword,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormFieldAuth(
                                label: 'Confirm Password',
                                controller: controller.confirmNewpassword,
                                validator: (val) {
                                  if (controller.newpassword.text != val) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              NormalButtonAuth(
                                text: 'Save Password',
                                onpress: () => controller.patchData(),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ));
  }
}
