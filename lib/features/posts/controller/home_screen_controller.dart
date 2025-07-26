import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:sociality/core/functions/show_dialog.dart';
import 'package:sociality/core/routes/app_routes.dart';
import 'package:sociality/core/services/shared_preferences_services.dart';
import 'package:sociality/core/services/user_services.dart';
import 'package:sociality/features/auth/screens/login_screen/login_screen.dart';
import 'package:sociality/utils/class/crud.dart';
import 'package:sociality/utils/class/enum.dart';
import 'package:sociality/utils/function/handlingdata.dart';
import 'package:sociality/utils/data/home_screen_data.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get to => Get.find<HomeScreenController>();

  late StatusRequest statusRequest;
  final UserService myServices = Get.find<UserService>();
  final SharedPreferencesService sharedPreferencesService =
      Get.find<SharedPreferencesService>();
  bool isEditPost = false;
  final PagingController pagingController = PagingController(firstPageKey: 1);
  HomeScreenData homeScreenData = HomeScreenData(Crud());
  String postEditId = '';
  GlobalKey<FormState> formState = GlobalKey();
  bool hasMore = true;
  late TextEditingController descriptionController;

  void onProfileTap(String value) async {
    await sharedPreferencesService.setString('user_profile_id', value);
    Get.toNamed(AppRoutes.profileScreen);
  }

  Future<void> likePost(String postId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final responce = await homeScreenData.likesData(postId);
      statusRequest = handlingData(responce);

      if (statusRequest == StatusRequest.success && responce['_id'] != null) {
        final items = pagingController.itemList;
        if (items != null) {
          final index = items.indexWhere((post) => post['_id'] == postId);
          if (index != -1) {
            items[index]['likes'] =
                responce['likes']; // Update likes count/list
            pagingController.itemList = List.from(items); // trigger UI update
            pagingController.notifyListeners();
          }
        }
        update();
      } else {
        statusRequest = StatusRequest.failure;
        update();
      }
    } catch (e) {
      showAlertDialog(e.toString());
      update();
    }
  }

  Future<void> getPosts(int pageKey) async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final response = await homeScreenData.getPostsData(pageKey);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success && response['posts'] != null) {
        print(response['posts']);
        final newItems = response['posts'] as List;
        final isLastPage = !(response['hasMore'] ?? false);

        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
        hasMore = !isLastPage;
      } else {
        pagingController.appendLastPage([]);
      }
    } catch (e) {
      pagingController.error = e;
    }
    update();
  }

  Future<void> sharePost() async {
    try {
      if (!formState.currentState!.validate()) {
        return;
      }
      statusRequest = StatusRequest.loading;
      update();
      var responce =
          await homeScreenData.sharePostsData(descriptionController.text);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['userId'] != null) {
          descriptionController.clear();

          final currentItem = pagingController.itemList ?? [];
          pagingController.itemList = [
            responce,
            ...currentItem,
          ];
          pagingController.notifyListeners();
          update();
        } else {
          statusRequest = StatusRequest.failure;
          update();
        }
      } else {
        statusRequest = StatusRequest.serverFailure;
        update();
      }
    } catch (e) {
      showAlertDialog(e.toString());
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

  String postTime(Map item) {
    String backendTimeString = item['createdAt'];
    DateTime backendTime = DateTime.parse(backendTimeString);
    String formattedTime = DateFormat.yMMMMd().add_jms().format(backendTime);
    return formattedTime;
  }

  Future<void> deletePost(String postId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final responce = await homeScreenData.deleteData(postId);
      statusRequest = handlingData(responce);

      if (statusRequest == StatusRequest.success &&
          responce['msg'] == 'Post has been deleted successfully') {
        final items = pagingController.itemList;
        if (items != null) {
          final index = items.indexWhere((post) => post['_id'] == postId);
          if (index != -1) {
            items.removeAt(index);
            pagingController.itemList = List.from(items); // trigger UI update
            pagingController.notifyListeners();
          }
        }
        update();
      } else {
        Get.defaultDialog(
          title: 'ALERT',
          content: Text(responce['msg'] ?? 'Failed to delete post'),
          onConfirm: () => Get.back(),
        );
        update();
      }
    } catch (e) {
      showAlertDialog(e.toString());
      update();
    }
  }

  void onEditTap(Map item) {
    descriptionController.text = item['description'];
    postEditId = item['_id'];
    isEditPost = true;
    update();
  }

  Future<void> editPost() async {
    try {
      if (!formState.currentState!.validate()) return;

      statusRequest = StatusRequest.loading;
      update();

      Map responce = await homeScreenData.editPostData(
        postEditId,
        descriptionController.text,
      );
      statusRequest = handlingData(responce);

      if (statusRequest == StatusRequest.success &&
          responce['description'] != null) {
        final items = pagingController.itemList;
        if (items != null) {
          final index = items.indexWhere((post) => post['_id'] == postEditId);
          if (index != -1) {
            items[index]['description'] = descriptionController.text;
            pagingController.itemList = List.from(items); // trigger UI update
            pagingController.notifyListeners();
          }
        }
        isEditPost = false;
        descriptionController.clear();
        update();
      } else {
        Get.defaultDialog(
          title: 'ALERT',
          content: Text(responce['msg'] ?? 'Failed to edit post'),
          onConfirm: () => Get.back(),
        );
        update();
      }
    } catch (e) {
      showAlertDialog(e.toString());
      update();
    }
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
