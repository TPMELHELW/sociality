import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/routes/app_routes.dart';
import 'package:sociality/core/widget/container_shape_widget.dart';
import 'package:sociality/core/widget/row_button_widget.dart';
import 'package:sociality/features/auth/controller/login_controller.dart';
import 'package:sociality/features/auth/screens/login_screen/widgets/login_form_widget.dart';
import 'package:sociality/core/widget/text_app_bar_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      appBar: const CustomAppBarWidget(
        text: 'Sociality',
        isLeading: false,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          children: [
            ContainerShapeWidget(
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
                  const LoginFormWidget(),
                  RowButtonWidget(
                      text: "Don't have an account ?",
                      buttonText: 'SignUp',
                      onpress: () => Get.offNamed(AppRoutes.signupScreen))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
