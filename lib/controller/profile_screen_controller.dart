import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/home_screen_data.dart';
import 'package:sociality/middleware/services.dart';

class ProfileScreenController extends GetxController {
  int currentPage = 1;
  late StatusRequest statusRequest;
  MyServices myServices = Get.find<MyServices>();
  HomeScreenData homeScreenData = HomeScreenData(Crud());
  List posts = [];
  bool hasMore = true;
  final PagingController pagingController = PagingController(firstPageKey: 0);

  Future getData() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      currentPage = 1;
      Map responce = await homeScreenData.profileData(
          myServices.sharedpref.getString('profileUserId'),
          {
            'Authorization':
                'Bearer ${myServices.sharedpref.getString('token')}'
          },
          currentPage);
      statusRequest = handlingData(responce);
      if (statusRequest == StatusRequest.success) {
        if (responce['posts'] != null) {
          hasMore = responce['hasMore'];

          posts.clear();
          posts.addAll(responce['posts']);
          return responce['posts'];
        } else {}
      } else {}
    } catch (e) {}
    update();
  }

  Future<void> fetchNewPage() async {
    try {
      final newItems = await getData();
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

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((page) {
      fetchNewPage();
    });
    statusRequest = StatusRequest.none;
  }
}
