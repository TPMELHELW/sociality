import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/common/widget/container_shape_widget.dart';
import 'package:sociality/features/auth/controller/auth_controller.dart';
import 'package:sociality/features/auth/widget/auth_bottom_widget.dart';
import 'package:sociality/features/auth/widget/auth_form_widget.dart';
import 'package:sociality/common/widget/text_app_bar_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            GetBuilder<AuthController>(
              init: AuthController(),
              builder: (controller) {
                return ContainerShapeWidget(
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
                        controller: controller,
                      ),
                      AuthBottomWidget(
                        controller: controller,
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
