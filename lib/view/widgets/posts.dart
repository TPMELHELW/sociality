import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sociality/core/model/menuitem.dart';
import 'package:sociality/core/model/menuitems.dart';

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
      required this.currentId});

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
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundColor: Color(0xFF757575),
                  maxRadius: 25,
                  backgroundImage: NetworkImage(profileImage),
                  onBackgroundImageError: (exception, stackTrace) =>
                      print('gfdsdf'),
                  // minRadius: 30,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(text,
                          style: TextStyle(
                              fontSize: 18.5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text(
                        '$formattedTime',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
              id == currentId
                  ? PopupMenuButton<MenuItem>(
                      itemBuilder: (context) => [
                        ...MenuItems.items.map(buildItems).toList(),
                      ],
                    )
                  : IconButton(onPressed: () {}, icon: Icon(Icons.add))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              body,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          if (isImage == true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            )
          else
            SizedBox(
              height: 0,
            ),
          Row(
            // mainAxisAlignment: ,
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                    ),
                  ),
                  Text(heart, style: TextStyle(color: Colors.white)),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                  ),
                  Text(comment, style: TextStyle(color: Colors.white)),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItems(MenuItem item) => PopupMenuItem(
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
