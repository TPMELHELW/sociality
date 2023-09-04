import 'package:get/get.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/core/class/crud.dart';

class CrudBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(LogInController());
  }
}
