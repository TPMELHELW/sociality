import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sociality/features/posts/controller/home_screen_controller.dart';
import 'package:sociality/features/posts/widget/posts_widget.dart';

class PostViewWidget extends StatelessWidget {
  const PostViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = HomeScreenController.to;
    return Expanded(
        child: PagedListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      pagingController: controller.pagingController,
      // itemExtent: 500,
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        itemBuilder: (context, dynamic item, index) {
          return Posts(
            controller: controller,
            isImage: false,
            item: item,
            index: index,
          ) as Widget;
        },
      ),
    ));
  }
}
