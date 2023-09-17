import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sociality/controller/infinitiscrollcontroller.dart';
import 'package:sociality/core/model/menuitem.dart';
import 'package:sociality/core/model/menuitems.dart';
import 'package:sociality/view/screen/editposts.dart';

class Posts extends StatelessWidget {
  final String text,
      body,
      image,
      profileImage,
      heart,
      comment,
      time,
      id,
      currentId;
  final bool isImage;
  final Color color;
  final Map controller;
  const Posts(
      {super.key,
      required this.text,
      required this.body,
      required this.image,
      required this.isImage,
      required this.profileImage,
      required this.heart,
      required this.comment,
      required this.time,
      required this.id,
      required this.currentId,
      required this.color,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    String backendTimeString = time;
    DateTime backendTime = DateTime.parse(backendTimeString);
    String formattedTime = DateFormat.yMMMMd().add_jms().format(backendTime);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  maxRadius: 25,
                  backgroundImage: NetworkImage(profileImage),
                  onBackgroundImageError: (exception, stackTrace) =>
                      print('gfdsdf'),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(text,
                          style: const TextStyle(
                              fontSize: 18.5, fontWeight: FontWeight.bold)),
                      Text(
                        formattedTime,
                      )
                    ],
                  )),
              id == currentId
                  ? PopupMenuButton<MenuItem>(
                      onSelected: (item) => onSelected(context, item),
                      itemBuilder: (context) => [
                        ...MenuItems.items.map(buildItems).toList(),
                      ],
                    )
                  : IconButton(onPressed: () {}, icon: const Icon(Icons.add))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              body,
              textAlign: TextAlign.left,
            ),
          ),
          if (isImage == true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  image,
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
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.heart,
                    ),
                  ),
                  Text(
                    heart,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.comment,
                    ),
                  ),
                  Text(
                    comment,
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
          )
        ],
      ),
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
  void onSelected(BuildContext contex, MenuItem item) {
    if (item == MenuItems.itemDelete) {
      print('mahmouf');
    } else if (item == MenuItems.itemEdit) {
      Get.to(EditPost(
        controllerScroll: controller,
      ));
      print(controller);
    }
  }
}
