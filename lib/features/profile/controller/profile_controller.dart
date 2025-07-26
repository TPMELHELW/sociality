import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sociality/core/functions/show_dialog.dart';
import 'package:sociality/core/services/shared_preferences_services.dart';
import 'package:sociality/utils/class/crud.dart';
import 'package:sociality/utils/class/enum.dart';
import 'package:sociality/utils/data/home_screen_data.dart';
import 'package:sociality/utils/function/handlingdata.dart';

class ProfileController extends GetxController {
  final PagingController pagingController = PagingController<int, dynamic>(
    firstPageKey: 1,
  );
  late StatusRequest statusRequest;
  final HomeScreenData homeScreenData = HomeScreenData(Crud());
  final SharedPreferencesService sharedPreferencesService =
      Get.find<SharedPreferencesService>();
  bool hasMore = true;

  Future getData(int pageKey) async {
    try {
      statusRequest = StatusRequest.loading;
      final response = await homeScreenData.profileData(
          await sharedPreferencesService.getString('user_profile_id'), pageKey);
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
        hasMore = !isLastPage;
      } else {}
    } catch (e) {
      log(e.toString());
      showAlertDialog(e.toString());
    }
    update();
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      getData(pageKey);
    });
    super.onInit();
  }
}
