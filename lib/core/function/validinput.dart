import 'package:get/get.dart';

validInput(val, min, max, type) {
  if (type == 'email') {
    if (!GetUtils.isEmail(val)) {
      return "Not Valid Email";
    }
  }
  if (type == 'username') {
    if (!GetUtils.isUsername(val)) {
      return "Not Valid UserName";
    }
  }

  if (val.length < min) {
    return 'Value Can Not Be Less Than $min';
  }
  if (val.length > max) {
    return 'Value Can Not Be More Than $max';
  }
  if (val.isEmpty) {
    return 'Value Can Not Be Empty';
  }
}
