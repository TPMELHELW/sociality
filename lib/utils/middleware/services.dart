import 'package:get/get.dart';
import 'package:sociality/core/services/shared_preferences_services.dart';
import 'package:sociality/core/services/user_services.dart';

class MyServices extends GetxService {
  Future<MyServices> init() async {
    // Register SharedPreferencesService asynchronously if needed
    Get.put<SharedPreferencesService>(SharedPreferencesService(),
        permanent: true);

    // Register UserService asynchronously
    await Get.putAsync<UserService>(() => UserService().init(),
        permanent: true);

    return this;
  }
}

Future<void> initServices() async {
  try {
    await Get.putAsync<MyServices>(() => MyServices().init(), permanent: true);
  } catch (e) {
    // You can use a logger here
    print('Service initialization failed: $e');
  }
}
