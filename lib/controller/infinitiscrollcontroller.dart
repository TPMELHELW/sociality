import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/handlingdata.dart';
import 'package:sociality/data/homescreendata.dart';
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

  // Future<void> _fetchData() async {
  //   if (isLoading || !hasNextPage) {
  //     return;
  //   }
  //   isLoading = true;
  //   update();
  //   try {
  //     final response = await http.get(
  //         Uri.parse(
  //             "https://social-medai-mern-b696.vercel.app/posts?page=$_page"),
  //         headers: {
  //           'Authorization': 'Bearer ${controller.inf[0]['accessToken']}',
  //         });
  //     final data = json.decode(response.body);
  //     posts.addAll(data['posts']);
  //     print(posts);
  //     if (_page == 0) {
  //       _page += 2;
  //     } else {
  //       _page++;
  //     }
      
  //     isLoading = false;
  //     update();
  //   } catch (e) {
  //     isLoading = false;
  //     update();
  //     print('Error: $e');
  //   }
  //   update();
  // }
MyServices myservices = Get.find();
  HomeScreenData data = HomeScreenData(Get.find());
  late StatusRequest statusRequest;
  Future<void> fetchData() async {
    statusRequest = StatusRequest.loading;
    isLoading = true;
    update();
    Map<String,String> token = {
      'Authorization': 'Bearer ${myservices.sharedpref.getString('token')}',
    };
    var responce = await data.getData(_page, token);
    statusRequest = handlingData(responce);
    
    if (statusRequest == StatusRequest.success) {
      if (responce['posts'] != null) {
        print(responce);
        posts.addAll(responce['posts']);
        if (_page == 0) {
          _page += 2;
        } else {
          _page++;
        }
        hasNextPage = responce['hasMore'];
        isLoading = false;
        update();
      }else{
        print('2');
      }
    }else{
      print('mmmmm');
      print(statusRequest);
    }
  
    update();
  }
}
