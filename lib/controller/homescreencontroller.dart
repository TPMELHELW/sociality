import 'package:get/get.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/data/homescreendata.dart';

class HomeScreenController extends GetxController {
  HomeScreenData data = HomeScreenData(Get.find());
  LogInController controller = Get.put(LogInController());

  List posts = [];

  getData0() async {
    try {
      var responce = await data.getData(controller.inf[0]['accessToken']);
      if (responce['posts'] != null) {
        // print(responce);
        // posts.add(responce);
        return responce;
      } else {
        print(responce['msg']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getData0();
    super.onInit();
  }
}
