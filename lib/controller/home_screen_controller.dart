import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/home_screen_data.dart';
import 'package:sociality/middleware/services.dart';
import 'package:sociality/view/screen/profile_screen.dart';

class HomeScreenController extends GetxController {
  late StatusRequest statusRequest;
  late MyServices myServices;
  final PagingController pagingController = PagingController(firstPageKey: 0);
  HomeScreenData homeScreenData = HomeScreenData(Crud());
  Map likeUpdate = {};
  int currentPage = 1;
  GlobalKey<FormState> formState = GlobalKey();
  bool hasMore = true;
  late TextEditingController descriptionController;
  List posts = [];

  void updateRequest(controller, responce) {
    final Map myMap = posts.asMap();
    final int index =
        myMap.keys.firstWhere((i) => myMap[i]!['_id'] == controller['_id']);
    posts[index]['likes'] = responce;
    update();
  }

  Future<void> like(Map item) async {
    statusRequest = StatusRequest.loading;
    Map responce = await homeScreenData.likesData(item['_id'], {
      'Authorization': 'Bearer ${myServices.sharedpref.getString('token')}'
    });
    statusRequest = handlingData(responce);
    if (statusRequest == StatusRequest.success) {
      if (responce['_id'] != null) {
        likeUpdate.addAll(responce);
        updateRequest(item, likeUpdate['likes']);
        update();
      } else {
        statusRequest = StatusRequest.failure;
        update();
      }
    } else {
      statusRequest = StatusRequest.serverFailure;
      update();
    }

    update();
  }

  Future fetchData() async {
    statusRequest = StatusRequest.loading;
    update();
    Map<String, String> token = {
      'Authorization': 'Bearer ${myServices.sharedpref.getString('token')}',
    };
    Map responce = await homeScreenData.getPostsData(currentPage, token);
    statusRequest = handlingData(responce);
    if (statusRequest == StatusRequest.success) {
      if (responce['posts'] != null) {
        hasMore = responce['hasMore'];
        posts.addAll(responce['posts']);
        return responce['posts'];
      } else if (responce['msg'] == "Token is not valid!") {
      } else {
        statusRequest = StatusRequest.failure;
        update();
      }
    } else {
      statusRequest = StatusRequest.serverFailure;
      update();
    }

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
    }
    update();
  }

  Future<void> postData() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      var responce = await homeScreenData.sharePostsData(
          descriptionController.text, {
        'Authorization': 'Bearer ${myServices.sharedpref.getString('token')}'
      });
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['userId'] != null) {
          descriptionController.clear();
        } else {
          statusRequest = StatusRequest.failure;
          update();
        }
      } else {
        statusRequest = StatusRequest.serverFailure;
        update();
      }
    }
  }

  Future<void> logOut() async {
    statusRequest = StatusRequest.loading;
    update();
    await homeScreenData.logOut({
      'Authorization': 'Bearer ${myServices.sharedpref.getString('token')}',
    });
    update();
  }

  Future<void> onProfileTap(Map item) async {
    myServices.sharedpref
        .setString('profileUserId', '${item['userId']['_id']}');
    Get.to(() => const ProfileScreen());
    update();
  }

  String postTime(Map item) {
    String backendTimeString = item['createdAt'];
    DateTime backendTime = DateTime.parse(backendTimeString);
    String formattedTime = DateFormat.yMMMMd().add_jms().format(backendTime);
    return formattedTime;
  }

  @override
  void onInit() {
    super.onInit();
    myServices = Get.find<MyServices>();
    pagingController.addPageRequestListener((page) {
      fetchNewPage();
    });
    descriptionController = TextEditingController();
    statusRequest = StatusRequest.none;
  }
}
