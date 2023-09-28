// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sociality/controller/infinitiscrollcontroller.dart';
import 'package:sociality/controller/likescontroller.dart';
import 'package:sociality/controller/profilescreencontroller.dart';
import 'package:sociality/core/model/menuitem.dart';
import 'package:sociality/core/model/menuitems.dart';
import 'package:sociality/data/addfriend.dart';
import 'package:sociality/data/deletepostdata.dart';
import 'package:sociality/middleware/middleware.dart';
import 'package:sociality/view/screen/editposts.dart';
import 'package:sociality/view/screen/profilescreen.dart';


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
  final List textComment;

  Posts(
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
      required this.controller,
      required this.textComment});

  @override
  Widget build(BuildContext context) {
    String backendTimeString = time;
    DateTime backendTime = DateTime.parse(backendTimeString);
    String formattedTime = DateFormat.yMMMMd().add_jms().format(backendTime);
    ProfileScreenController controller1 = Get.put(ProfileScreenController());
    AddFriendData addFreind = AddFriendData(Get.find());
    Scroll controller3 = Get.put(Scroll());
    bool isExist = false;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GetBuilder<PostController>(
          init: PostController(),
          autoRemove: false,
          builder: (controller0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () async {
                          await controller1.getData(id);
                          Get.to(() => const ProfileScreen());
                        },
                        child: CircleAvatar(
                          maxRadius: 25,
                          backgroundImage: NetworkImage(profileImage),
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
                            Text(text,
                                style: const TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.bold)),
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
                        : IconButton(
                            onPressed: () async {
                              var responce = await addFreind.addFriend(
                                  currentId, id, {
                                'Authorization':
                                    'Bearer ${myservices.sharedpref.getString('token')}'
                              });
                              print(responce);
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
                          onPressed: () async {
                            await controller0.like(
                                controller['_id'], controller['userId']['_id']);
                            controller3.updateRequest(
                                controller, controller0.likeUpdate['likes']);
                            controller0.update();
                          },
                          icon: Icon(
                            controller['likes'][currentId] != null
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                          ),
                        ),
                        Text(
                          heart,
                        ),
                        IconButton(
                          onPressed: () {
                            isExist = !isExist;
                            controller0.update();
                            Get.bottomSheet(Container(
                              padding: const EdgeInsets.only(top: 20),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30)),
                                  color: Colors.white),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Expanded(
                                            flex: 1, child: CircleAvatar()),
                                        Expanded(
                                          flex: 3,
                                          child: Form(
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Write Your Comment  ',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(40, 45),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: const Text('Comment'),
                                        )
                                      ],
                                    ),
                                    ListView.separated(
                                      // scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: textComment.length,
                                      itemBuilder: (context, i) => comment ==
                                              "0"
                                          ? const SizedBox(
                                              height: 0,
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: CircleAvatar(
                                                      maxRadius: 25,
                                                      backgroundImage:
                                                          NetworkImage(textComment[
                                                                  i]['postedBy']
                                                              ['picturePath']),
                                                      onBackgroundImageError:
                                                          (exception,
                                                                  stackTrace) =>
                                                              print('gfdsdf'),
                                                    )),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Text(
                                                        textComment[i]
                                                                ['postedBy']
                                                            ['firstName'],
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(textComment[i]
                                                          ['text'])
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Divider();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          },
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
                ),
              ],
            );
          }),
    );
  }

  DeletePostData delete = DeletePostData(Get.find());
  MyServices myservices = Get.find();
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
  deletedata() async {
    var responce = await delete.deleteData(controller['_id'], {
      'Authorization': 'Bearer ${myservices.sharedpref.getString('token')}'
    });
    if (responce['msg'] == 'Post has been deleted successfully') {
      Get.offAllNamed('/homescreen');
    }
  }

  void onSelected(BuildContext contex, MenuItem item) {
    if (item == MenuItems.itemDelete) {
      deletedata();
    } else if (item == MenuItems.itemEdit) {
      Get.to(EditPost(
        controllerScroll: controller,
      ));
     
    }
  }
}
