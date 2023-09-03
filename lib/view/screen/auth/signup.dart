import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/signupcontroller.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/view/screen/auth/login.dart';
import 'package:sociality/view/widgets/auth/normalbuttonauth.dart';
import 'package:sociality/view/widgets/auth/textbutton.dart';
import 'package:sociality/view/widgets/auth/textformfield.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // SignUpController controller = Get.put(SignUpController());
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TextAppBar(),
          centerTitle: true,
        ),
        body: GetBuilder<SignUpController>(
          init: SignUpController(),
          builder: (controller) =>
              controller.statusrequest == StatusRequest.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const Text(
                              'Welcome to Sociality',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: controller.formstate,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormFieldAuth(
                                          controller: controller.firstName,
                                          label: 'First Name',
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormFieldAuth(
                                          controller: controller.lastName,
                                          label: 'Last Name',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormFieldAuth(
                                    controller: controller.location,
                                    label: 'Location',
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormFieldAuth(
                                    controller: controller.occupation,
                                    label: 'Ocuupation',
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
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
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            NormalButtonAuth(
                              text: 'Register',
                              onpress: () async {
                                await controller.signup();
                              },
                            ),
                            Row(
                              children: [
                                Text("Already have an account ? "),
                                TextButtonAuth(
                                  text: 'Login here.',
                                  onpress: () => Get.to(() => LogIn()),
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
