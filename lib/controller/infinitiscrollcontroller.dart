import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sociality/controller/logincontroller.dart';

class Scroll extends GetxController  {
  int _page = 0;
  bool isLoading = false;
  bool hasNextPage = true;
  List<dynamic> posts = [];
  ScrollController scrollController = ScrollController();
late LogInController controller ;
  // @override
  // void initState() {
  //   super.initState();
  //   scrollController.addListener(_scrollListener);
  //   _fetchData();
  // }
  @override
  void onInit() {
   controller = Get.put(LogInController());
  
    scrollController.addListener(_scrollListener);
    _fetchData();
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
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    if (isLoading || !hasNextPage) {
      return;
    }
    isLoading = true;
    update();
    try {
      final response = await http.get(
          Uri.parse(
              "https://social-medai-mern-b696.vercel.app/posts?page=$_page"),
          headers: {
            'Authorization': 'Bearer ${controller.inf[0]['accessToken']}',
          });
      final data = json.decode(response.body);
      posts.addAll(data['posts']);
      if(_page == 0){
        _page += 2;
      }else{
        _page++;
      }
      hasNextPage = data['hasMore'];
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      print('Error: $e');
    }
    update();
  }
}
