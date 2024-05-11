import 'package:flutter/material.dart';
import 'package:sociality/features/settings/controller/settings_controller.dart';

List<String> fields = [
  'Email',
  'Location',
  'Ocupation',
  'Password',
];
SettingsController controller = SettingsController();
List<TextEditingController> fieldsController = [
  controller.email,
  controller.location,
  controller.occupation,
  controller.password,
];
