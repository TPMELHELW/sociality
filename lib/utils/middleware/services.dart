import 'package:get/get.dart';
import 'package:sociality/core/services/shared_preferences_services.dart';
import 'package:sociality/core/services/user_services.dart';

class MyServices extends GetxService {
  Future<MyServices> init() async {
    Get.put(SharedPreferencesService());

    await Get.putAsync(() => UserService().init());
    return this;
  }
}

Future<void> initial() async {
  await Get.putAsync(() => MyServices().init());
}
