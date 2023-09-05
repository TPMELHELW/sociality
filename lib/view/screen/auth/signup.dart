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
        // backgroundColor: Colors.grey,
        appBar: AppBar(
          // backgroundColor: Colors.transparent,
          elevation: 0,
          title: TextAppBar(),
          centerTitle: true,
        ),
        body: GetBuilder<SignUpController>(
          init: SignUpController(),
          builder: (controller) => controller.statusrequest ==
                  StatusRequest.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color:
                                  myServices.sharedpref.getBool('dark') == true
                                      ? Color(0xFF242526)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        myServices.sharedpref.getBool('dark') ==
                                                false
                                            ? Color(0xFF242526)
                                            : Colors.white,
                                    spreadRadius: 5,
                                    blurRadius: 20)
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
                                    onpress: () => Get.offAll(() => LogIn()),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller0.onpress();
                                    controller.update();
                                  },
                                  icon: Icon(Icons.light))
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
