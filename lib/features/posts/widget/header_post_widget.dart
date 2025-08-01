import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/features/posts/controller/home_screen_controller.dart';
import 'package:sociality/utils/model/menuitem.dart';
import 'package:sociality/utils/model/menuitems.dart';

class HeaderPostWidget extends StatelessWidget {
  final Map item;
  final int index;
  HeaderPostWidget({super.key, required this.item, required this.index});

  final HomeScreenController controller = HomeScreenController.to;
  @override
  Widget build(BuildContext context) {
    final currentId = controller.myServices.currentUser.value?.user?.sId ?? '';
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => controller.onProfileTap('${item['userId']['_id']}'),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundImage: NetworkImage('${item['userId']['picturePath']}'),
              onBackgroundImageError: (exception, stackTrace) =>
                  print('gfdsdf'),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: () => controller.onProfileTap('${item['userId']['_id']}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${item['userId']['firstName']}',
                    style: const TextStyle(
                        fontSize: 18.5, fontWeight: FontWeight.bold)),
                Text(
                  controller.postTime(item),
                )
              ],
            ),
          ),
        ),
        '${item['userId']['_id']}' == currentId
            ? PopupMenuButton<MenuItem>(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                  ...MenuItems.items.map(buildItems).toList(),
                ],
              )
            : GetBuilder<HomeScreenController>(
                builder: (controller) {
                  final friends =
                      controller.myServices.currentUser.value?.user?.friends ??
                          [];
                  final isFriend = friends.contains(item['userId']['_id']);
                  return IconButton(
                    onPressed: isFriend
                        ? () async => await controller.removeFriend(
                            currentId, item['userId']['_id'])
                        : () async => await controller.addFriend(
                            currentId, item['userId']['_id']),
                    icon: Icon(
                      isFriend ? Icons.check : Icons.add,
                      color: isFriend ? Colors.green : null,
                    ),
                  );
                },
              )
      ],
    );
  }

  void onSelected(BuildContext contex, MenuItem items) {
    if (items == MenuItems.itemDelete) {
      controller.deletePost(item['_id']);
    } else if (items == MenuItems.itemEdit) {
      controller.onEditTap(item);
    }
  }

  PopupMenuItem<MenuItem> buildItems(MenuItem item) => PopupMenuItem<MenuItem>(
        value: item,
        child: Row(
          children: [
            Icon(item.icon),
            Text(
              item.text,
            ),
          ],
        ),
      );
}
