import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/auth_controller.dart';
import 'package:sociality/middleware/services.dart';
import 'package:sociality/view/widgets/auth/auth_form_widget.dart';
import 'package:sociality/view/widgets/auth/auth_button_widget.dart';
import 'package:sociality/view/widgets/auth/auth_text_button_widget.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class AuthScreen extends StatelessWidget {
  final bool isLogin;
  const AuthScreen({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    AuthController controller = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const TextAppBar(
          text: 'Sociality',
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                    AuthFormWidget(
                      isLogin: isLogin,
                      controller: controller,
                    ),
                    AuthButtonWidget(
                      text: isLogin ? 'LogIn' : 'SignUp',
                      onpress: () async {
                        isLogin
                            ? await controller.logIn()
                            : await controller.signup();
                      },
                    ),
                    Row(
                      children: [
                        Text(isLogin
                            ? "Don't have an account ?"
                            : "Already have an Account ?"),
                        AuthTextButton(
                          text: !isLogin ? 'Login here' : 'Sign Up here',
                          onpress: () {
                            Get.delete<AuthController>();
                            Get.offAll(
                              () => AuthScreen(
                                isLogin: !isLogin,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
