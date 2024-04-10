import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/settings_controller.dart';
import 'package:sociality/view/widgets/auth/auth_button_widget.dart';
import 'package:sociality/view/widgets/textappbar.dart';
import 'package:sociality/view/widgets/textformfieldsettings.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextAppBar(
          text: 'Settings',
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/homescreen');
          },
          icon: const Icon(Icons.home),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (controller0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  Form(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldSettings(
                                  controller: controller0.firstName,
                                  label: 'First Name',
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: TextFormFieldSettings(
                                  controller: controller0.lastName,
                                  label: 'Last Name',
                                ),
                              )
                            ],
                          ),
                          TextFormFieldSettings(
                            controller: controller0.email,
                            label: 'Email',
                          ),
                          TextFormFieldSettings(
                            controller: controller0.location,
                            label: 'Location',
                          ),
                          TextFormFieldSettings(
                            controller: controller0.occupation,
                            label: 'Occupation',
                          ),
                          TextFormFieldSettings(
                            controller: controller0.password,
                            label: 'Password',
                          ),
                        ]),
                  ),
                  AuthButtonWidget(
                    text: 'Update',
                    onpress: () async {
                      await controller0.updateData();
                    },
                  )
                ],
              ),
            );
          }),
    );
  }
}
