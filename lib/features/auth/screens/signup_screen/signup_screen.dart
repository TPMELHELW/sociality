import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/routes/app_routes.dart';
import 'package:sociality/core/widget/container_shape_widget.dart';
import 'package:sociality/core/widget/row_button_widget.dart';
import 'package:sociality/features/auth/controller/signup_controller.dart';
import 'package:sociality/features/auth/screens/signup_screen/widgets/signup_form_widget.dart';
import 'package:sociality/core/widget/text_app_bar_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
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
                  const SignupFormWidget(),
                  RowButtonWidget(
                    text: "Already have an account ?",
                    buttonText: 'Sign In',
                    onpress: () => Get.offNamed(AppRoutes.loginScreen),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
