import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/view/screen/auth/signup.dart';
import 'package:sociality/view/widgets/auth/normalbuttonauth.dart';
import 'package:sociality/view/widgets/auth/textbutton.dart';
import 'package:sociality/view/widgets/auth/textformfield.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    // Crud crud = Crud();
    // LogInController controller = Get.put(LogInController());
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TextAppBar(),
          centerTitle: true,
        ),
        body: GetBuilder<LogInController>(
          init: LogInController(),
          builder: (controller) =>
              controller.statusRequest == StatusRequest.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text(
                              'Welcome to Sociality',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: controller.formstate,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFormFieldAuth(
                                    controller: controller.email,
                                    label: 'Email',
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormFieldAuth(
                                    controller: controller.password,
                                    label: 'Password',
                                  ),
                                  TextButtonAuth(
                                    text: 'Forget Passowrd?',
                                  )
                                ],
                              ),
                            ),
                            NormalButtonAuth(
                              text: 'LogIn',
                              onpress: () async {
                                await controller.logIn();
                              },
                            ),
                            Row(
                              children: [
                                Text("Don't have an account ?"),
                                TextButtonAuth(
                                  text: 'Sign Up here',
                                  onpress: () => Get.offAll(() => SignUp()),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
        ));
  }
}
