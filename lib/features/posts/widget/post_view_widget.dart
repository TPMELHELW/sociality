import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sociality/features/posts/controller/home_screen_controller.dart';
import 'package:sociality/features/posts/widget/posts_widget.dart';

class PostViewWidget extends StatelessWidget {
  final HomeScreenController controller;
  const PostViewWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PagedListView(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        itemBuilder: (context, dynamic item, index) {
          return Text('fff');
          // return Posts(
          //   controller: controller,
          //   isImage: false,
          //   currentId: "${controller.myServices.sharedpref.getString('id')}",
          //   color: controller.myServices.sharedpref.getBool('dark') == true
          //       ? const Color(0xFF242526)
          //       : Colors.white,
          //   item: controller.isProfile
          //       ? controller.profilePosts[index]
          //       : controller.posts[index],
          //   index: index,
          // ) as Widget;
        },
      ),
    ));
  }
}
