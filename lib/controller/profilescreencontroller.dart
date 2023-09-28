import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/profilescreendata.dart';
import 'package:sociality/middleware/middleware.dart';

class ProfileScreenController extends GetxController {
  ProfileScreenData getdata = ProfileScreenData(Get.find());
  late StatusRequest statusRequest;
  MyServices myservices = Get.find();
  List posts = [];
  int _page = 0;
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  getData(userId) async {
    statusRequest = StatusRequest.loading;
    isLoading = true;
    update();
    Map responce = await getdata.getData(
        userId,
        {'Authorization': 'Bearer ${myservices.sharedpref.getString('token')}'},
        _page);
    statusRequest = handlingData(responce);
    if (statusRequest == StatusRequest.success) {
      if (responce['posts'] != null) {
        posts.addAll(responce['posts']);
        if (_page == 0) {
          _page += 2;
        } else {
          _page++;
        }
        isLoading = false;
        update();
      } else {}
    } else {}
    update();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    statusRequest = StatusRequest.none;
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  void _scrollListener() {
    if (!isLoading &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
      getData(posts[0]['userId']['_id']);
    }
  }
}
