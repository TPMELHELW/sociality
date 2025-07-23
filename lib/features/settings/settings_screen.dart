import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/features/posts/home_screen.dart';
import 'package:sociality/features/settings/controller/settings_controller.dart';
import 'package:sociality/core/widget/auth_button_widget.dart';
import 'package:sociality/core/widget/text_app_bar_widget.dart';
import 'package:sociality/features/settings/data/fields_data.dart';
import 'package:sociality/features/settings/widget/form_widget.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        text: 'Settings',
        isLeading: true,
        isAction: false,
        onPress: () => Get.offAll(
          () => const HomeScreen(),
        ),
      ),
      body: GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller0) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              FormWidget(controller: controller),
              ButtonWidget(
                text: 'Update',
                onpress: () async {
                  await controller0.updateData();
                },
                isAuth: false,
                statusRequest: controller.statusRequest,
              )
            ],
          );
        },
      ),
    );
  }
}
