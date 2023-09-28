import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/signupcontroller.dart';
import 'package:sociality/controller/themedata.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/middleware/middleware.dart';
import 'package:sociality/view/screen/auth/login.dart';
import 'package:sociality/view/widgets/auth/normalbuttonauth.dart';
import 'package:sociality/view/widgets/auth/textbutton.dart';
import 'package:sociality/view/widgets/auth/textformfield.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController controller0 = ThemeController();
    MyServices myServices = Get.find();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const TextAppBar(
            text: 'Sign Up',
          ),
          centerTitle: true,
        ),
        body: GetBuilder<SignUpController>(
          init: SignUpController(),
          builder: (controller) => controller.statusrequest ==
                  StatusRequest.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color:
                                  myServices.sharedpref.getBool('dark') == true
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormFieldAuth(
                                            controller: controller.firstName,
                                            label: 'First Name',
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormFieldAuth(
                                            controller: controller.lastName,
                                            label: 'Last Name',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormFieldAuth(
                                      controller: controller.location,
                                      label: 'Location',
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormFieldAuth(
                                      controller: controller.occupation,
                                      label: 'Ocuupation',
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormFieldAuth(
                                      controller: controller.email,
                                      label: 'Email',
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormFieldAuth(
                                      controller: controller.password,
                                      label: 'Password',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
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
                                  const Text("Already have an account ? "),
                                  TextButtonAuth(
                                    text: 'Login here.',
                                    onpress: () =>
                                        Get.offAll(() => const LogIn()),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller0.onpress();
                                    controller.update();
                                  },
                                  icon: const Icon(Icons.light))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}
