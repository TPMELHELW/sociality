import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/home_screen_data.dart';
import 'package:sociality/middleware/middleware.dart';

class HomeScreenController extends GetxController {
  late StatusRequest statusRequest;
  MyServices myServices = Get.find<MyServices>();
  final PagingController pagingController = PagingController(firstPageKey: 0);
  HomeScreenData homeScreenData = HomeScreenData(Crud());
  int currentPage = 1;
  GlobalKey<FormState> formState = GlobalKey();
  MyServices myservices = Get.find();
  bool hasMore = true;
  late TextEditingController descriptionController;

  updateRequest(controller, responce) {
    // final myMap = posts.asMap();
    // final index =
    //     myMap.keys.firstWhere((i) => myMap[i]!['_id'] == controller['_id']);
    // posts[index]['likes'] = responce;
    // update();
  }

  Future fetchData() async {
    statusRequest = StatusRequest.loading;
    update();
    Map<String, String> token = {
      'Authorization': 'Bearer ${myServices.sharedpref.getString('token')}',
    };
    Map responce = await homeScreenData.getData(currentPage, token);
    statusRequest = handlingData(responce);
    if (statusRequest == StatusRequest.success) {
      if (responce['posts'] != null) {
        hasMore = responce['hasMore'];
        return responce['posts'];
      } else if (responce['msg'] == "Token is not valid!") {
      } else {}
    } else {}

    update();
  }

  Future<void> fetchNewPage() async {
    try {
      final newItems = await fetchData();
      if (hasMore) {
        pagingController.appendPage(newItems, currentPage++);
        update();
      } else {
        pagingController.appendLastPage(newItems);
        update();
      }
    } catch (e) {
      pagingController.error = e;
      print(e);
    }
    update();
  }

  Future<void> postData() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      var responce = await homeScreenData.postData(descriptionController.text, {
        'Authorization': 'Bearer ${myservices.sharedpref.getString('token')}'
      });
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['userId'] != null) {
          descriptionController.clear();
        } else {}
      } else {}
    }
  }

  logOut() async {
    statusRequest = StatusRequest.loading;
    var responce = await homeScreenData.logout({
      'Authorization': 'Bearer ${myservices.sharedpref.getString('token')}',
    });
    statusRequest = handlingData(responce);

    if (statusRequest == StatusRequest.success) {
    } else {}
  }

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((page) {
      fetchNewPage();
    });
    descriptionController = TextEditingController();
    statusRequest = StatusRequest.none;
  }
}
