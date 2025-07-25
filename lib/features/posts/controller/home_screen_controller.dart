import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:sociality/core/services/user_services.dart';
import 'package:sociality/features/auth/screens/login_screen/login_screen.dart';
import 'package:sociality/utils/class/crud.dart';
import 'package:sociality/utils/class/enum.dart';
import 'package:sociality/utils/function/handlingdata.dart';
import 'package:sociality/utils/data/home_screen_data.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get to => Get.find<HomeScreenController>();

  bool isProfile = false;
  late StatusRequest statusRequest;
  final UserService myServices = Get.find<UserService>();
  bool isEditPost = false;
  final PagingController pagingController = PagingController(firstPageKey: 0);
  HomeScreenData homeScreenData = HomeScreenData(Crud());
  Map likeUpdate = {};
  int currentPage = 1;
  String postEditId = '';
  GlobalKey<FormState> formState = GlobalKey();
  bool hasMore = true;
  late TextEditingController descriptionController;
  List posts = [];
  List profilePosts = [];

  void updateRequest(controller, responce) {
    final Map myMap = posts.asMap();
    final int index =
        myMap.keys.firstWhere((i) => myMap[i]!['_id'] == controller['_id']);
    posts[index]['likes'] = responce;
    update();
  }

  Future<void> like(Map item) async {
    statusRequest = StatusRequest.loading;
    Map responce = await homeScreenData.likesData(
      item['_id'],
    );
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

  Future getData() async {
    try {
      print('getData');
      statusRequest = StatusRequest.loading;
      Map responce = await homeScreenData.profileData(
          myServices.currentUser.value?.user?.sId ?? '', currentPage);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['posts'] != null) {
          hasMore = responce['hasMore'];
          print(responce['posts']);
          profilePosts.addAll(responce['posts']);
          return responce['posts'];
        } else {}
      } else {}
    } catch (e) {}
    update();
  }

  // Future<List<dynamic>> fetchData() async {
  //   try {
  //     statusRequest = StatusRequest.loading;
  //     update();

  //     Map response = await homeScreenData.getPostsData(currentPage);
  //     statusRequest = handlingData(response);

  //     if (statusRequest == StatusRequest.success) {
  //       if (response['posts'] != null) {
  //         hasMore = response['hasMore'];
  //         posts.addAll(response['posts']);
  //         update();
  //         return response['posts'];
  //       } else {
  //         statusRequest = StatusRequest.failure;
  //         update();
  //         return [];
  //       }
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //       update();
  //       return [];
  //     }
  //   } catch (e) {
  //     statusRequest = StatusRequest.failure;
  //     showAlertDialog(e.toString());
  //     update();
  //     return [];
  //   }
  // }

  Future<void> getPosts(int pageKey) async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      Map response = await homeScreenData.getPostsData(pageKey);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success && response['posts'] != null) {
        final newItems = response['posts'] as List;
        final isLastPage = !(response['hasMore'] ?? false);

        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
        // posts.addAll(newItems); // Keep your posts list updated if needed
        hasMore = !isLastPage;
      } else {
        pagingController.appendLastPage([]);
      }
    } catch (e) {
      pagingController.error = e;
    }
    update();
  }

  // Future<void> fetchNewPage() async {
  //   try {
  //     final newItems = await fetchData();
  //     if (hasMore) {
  //       pagingController.appendPage(newItems, currentPage++);
  //     } else {
  //       pagingController.appendLastPage(newItems);
  //     }
  //   } catch (e) {
  //     pagingController.error = e;
  //   }
  // }

  Future<void> sharePost() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var responce =
          await homeScreenData.sharePostsData(descriptionController.text);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['userId'] != null) {
          descriptionController.clear();
          posts.insert(0, responce);
          update();
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
    // myServices.sharedpref.clear();
    await homeScreenData.logOutData();

    Get.delete<HomeScreenController>();
    Get.off(
      () => const LoginScreen(),
    );
    update();
  }

  void onProfileTap(Map item) {
    // myServices.sharedpref
    //     .setString('profileUserId', '${item['userId']['_id']}');
    currentPage = 1;
    profilePosts.clear();
    isProfile = true;
    pagingController.refresh();
    update();
  }

  String postTime(Map item) {
    String backendTimeString = item['createdAt'];
    DateTime backendTime = DateTime.parse(backendTimeString);
    String formattedTime = DateFormat.yMMMMd().add_jms().format(backendTime);
    return formattedTime;
  }

  Future deletedata(Map item, int index) async {
    var responce = await homeScreenData.deleteData(item['_id']);
    update();
    if (responce['msg'] == 'Post has been deleted successfully') {
      //TODO:delete error
      posts.removeAt(index);

      update();
    }
    update();
  }

  void onEditTap(Map item) {
    descriptionController.text = item['description'];
    postEditId = item['_id'];
    isEditPost = true;
    update();
  }

  Future<void> editPost() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map responce = await homeScreenData.editPostData(
          postEditId, descriptionController.text);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['description'] != null) {
          final Map myMap = posts.asMap();
          final int index =
              myMap.keys.firstWhere((i) => myMap[i]!['_id'] == postEditId);
          posts[index]['description'] = descriptionController.text;
          update();
        } else {
          Get.defaultDialog(
            title: 'ALERT',
            content: Text(responce['msg']),
            onConfirm: () => Get.back(),
          );
        }
      }
    }
    update();
  }

  void onBackTap() {
    isProfile = false;
    pagingController.refresh();
    update();
  }

  @override
  void onClose() {
    pagingController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((page) {
      getPosts(page);
    });
    descriptionController = TextEditingController();
    statusRequest = StatusRequest.none;
  }
}
