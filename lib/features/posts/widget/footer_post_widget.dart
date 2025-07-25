import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sociality/features/posts/controller/home_screen_controller.dart';
import 'package:sociality/features/posts/widget/comment_widget.dart';

class FooterPostWidget extends StatelessWidget {
  final Map item;
  const FooterPostWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = HomeScreenController.to;
    final currentId = controller.myServices.currentUser.value?.user?.sId ?? '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () async => await controller.like(item),
              icon: Icon(
                item['likes'][currentId] != null
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart,
              ),
            ),
            Text(
              '${item['likes'].length}',
            ),
            IconButton(
              onPressed: () => onCommentPress(item),
              icon: const Icon(
                Icons.comment,
              ),
            ),
            Text(
              '${item['comments'].length}',
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
          ),
        ),
      ],
    );
  }
}
