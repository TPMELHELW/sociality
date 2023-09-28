import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/homescreendata.dart';
import 'package:sociality/data/refreshdata.dart';
import 'package:sociality/middleware/middleware.dart';

class Scroll extends GetxController {
  int _page = 0;
  bool isMore = false;
  bool isLoading = false;
  bool hasNextPage = true;
  List<dynamic> posts = [];
  final now = DateTime.now();
  ScrollController scrollController = ScrollController();
  LogInController controller = Get.find();
  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    // _fetchData();
    fetchData();
    statusRequest = StatusRequest.none;
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!isLoading &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
      fetchData();
    }
  }

  updateRequest(controller, responce) {
    final myMap = posts.asMap();
    final index =
        myMap.keys.firstWhere((i) => myMap[i]!['_id'] == controller['_id']);
    posts[index]['likes'] = responce;
    update();
  }

  MyServices myservices = Get.find();
  HomeScreenData data = HomeScreenData(Get.find());
  late StatusRequest statusRequest;

  RefreshData ref = RefreshData(Get.find());
  Future<void> fetchData() async {
    statusRequest = StatusRequest.loading;
    isLoading = true;
    update();
    Map<String, String> token = {
      'Authorization': 'Bearer ${myservices.sharedpref.getString('token')}',
    };
    Map responce = await data.getData(_page, token);
    statusRequest = handlingData(responce);

    if (statusRequest == StatusRequest.success) {
      if (responce['posts'] != null) {
        posts.addAll(responce['posts']);
        if (_page == 0) {
          _page += 2;
        } else {
          _page++;
        }
        hasNextPage = responce['hasMore'];
        isLoading = false;
        update();
      } else if (responce['msg'] == "Token is not valid!") {
      } else {}
    } else {}

    update();
  }
}
