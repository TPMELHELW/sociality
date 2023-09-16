import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/controller/themedata.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/middleware/middleware.dart';
import 'package:sociality/view/screen/auth/signup.dart';
import 'package:sociality/view/widgets/auth/normalbuttonauth.dart';
import 'package:sociality/view/widgets/auth/textbutton.dart';
import 'package:sociality/view/widgets/auth/textformfield.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController controller0 = ThemeController();
    MyServices myServices = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const TextAppBar(),
        centerTitle: true,
      ),
      body: GetBuilder<LogInController>(
        init: LogInController(),
        builder: (controller) => controller.statusRequest ==
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
                            color: myServices.sharedpref.getBool('dark') == true
                                ? const Color(0xFF242526)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color:Color.fromRGBO(0, 0, 0, 0.2),
                                  spreadRadius: -1,
                                  blurRadius: 1)
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
                                   TextButtonAuth(
                                    text: 'Forget Passowrd?',
                                    onpress: (){
                                      Get.offAllNamed('/resetpassword');
                                    },
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
                                const Text("Don't have an account ?"),
                                TextButtonAuth(
                                  text: 'Sign Up here',
                                  onpress: () =>
                                      Get.offAll(() => const SignUp()),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  controller0.onpress();
                                  controller.update();
                                },
                                icon: const Icon(Icons.light)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
