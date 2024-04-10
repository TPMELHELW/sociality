import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/home_screen_controller.dart';
import 'package:sociality/core/model/menuitem.dart';
import 'package:sociality/core/model/menuitems.dart';
import 'package:sociality/view/screen/editposts.dart';
import 'package:sociality/view/screen/home_screen.dart';
import 'package:sociality/view/widgets/homescreen/comment_widget.dart';

class Posts extends StatelessWidget {
  final String currentId;
  final bool isImage;
  final Color color;
  final Map item;
  final controller;

  const Posts({
    super.key,
    required this.currentId,
    required this.isImage,
    required this.color,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Get.find<HomeScreenController>();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GetBuilder<HomeScreenController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => controller.onProfileTap(item),
                    child: CircleAvatar(
                      maxRadius: 25,
                      backgroundImage:
                          NetworkImage('${item['userId']['picturePath']}'),
                      onBackgroundImageError: (exception, stackTrace) =>
                          print('gfdsdf'),
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
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
                    )),
                '${item['userId']['_id']}' == currentId
                    ? PopupMenuButton<MenuItem>(
                        onSelected: (item) => onSelected(context, item),
                        itemBuilder: (context) => [
                          ...MenuItems.items.map(buildItems).toList(),
                        ],
                      )
                    : IconButton(
                        onPressed: () async {
                          await controller.homeScreenData.addFriend(
                              currentId, '${item['userId']['_id']}', {
                            'Authorization':
                                'Bearer ${controller.myServices.sharedpref.getString('token')}'
                          });
                        },
                        icon: const Icon(Icons.add))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${item['description']}',
                textAlign: TextAlign.left,
              ),
            ),
            if (isImage == true)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    '${item['picturePath']}',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const SizedBox(
                height: 0,
              ),
            Row(
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
            ),
          ],
        );
      }),
    );
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
  Future deletedata() async {
    var responce = await controller.homeScreenData.deleteData(item['_id'], {
      'Authorization':
          'Bearer ${controller.myServices.sharedpref.getString('token')}'
    });
    if (responce['msg'] == 'Post has been deleted successfully') {
      Get.offAll(() => const HomeScreen());
    }
  }

  void onSelected(BuildContext contex, MenuItem items) {
    if (items == MenuItems.itemDelete) {
      deletedata();
    } else if (items == MenuItems.itemEdit) {
      Get.to(
        () => EditPost(
          controllerScroll: item,
        ),
      );
    }
  }
}
