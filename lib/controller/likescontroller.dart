import 'package:get/get.dart';
import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/likesdata.dart';
import 'package:sociality/middleware/middleware.dart';

class PostController extends GetxController {
  MyServices myservices = Get.find();
  LikesData likes = LikesData(Crud());
  late StatusRequest statusRequest;
  Map likeUpdate = {};
  bool isExist = false;
  like(postId, userid) async {
    statusRequest = StatusRequest.loading;
    Map responce = await likes.likes(postId, {
      'Authorization': 'Bearer ${myservices.sharedpref.getString('token')}'
    });
    statusRequest = handlingData(responce);
    if (statusRequest == StatusRequest.success) {
      if (responce['_id'] != null) {
        likeUpdate.addAll(responce);
        update();
      } else {}
    } else {}

    update();
  }
}
