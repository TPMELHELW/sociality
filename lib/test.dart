import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/infinitiscrollcontroller.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/controller/sharepostscontroller.dart';
import 'package:sociality/view/widgets/textappbar.dart';

import 'controller/themedata.dart';
import 'middleware/middleware.dart';
import 'view/widgets/homescreen/posts.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    // TestController controller = Get.put(TestController());
    // Scroll controller0 = Get.put(Scroll());
    LogInController controller1 = Get.find();
    SharePostsController controller2 = Get.put(SharePostsController());
    ThemeController controller0 = ThemeController();
    MyServices myservices = Get.find();
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const TextAppBar(),
        centerTitle: true,
      ),
      body: Column(
        // alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF757575),
                        maxRadius: 25,
                        // minRadius: 30,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "What`s on your mind...",
                            fillColor: const Color(0xFF333333),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: 2.5,
                  color: Color(0xFF363636),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.image),
                      label: const Text('Images'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Share'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: GetBuilder<Scroll>(
                  init: Scroll(),
                  builder: (controller) {
                    return ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.posts.length +
                          (controller.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < controller.posts.length) {
                          // final post = _posts[index];
                          return Posts(
                            text:
                                '${controller.posts[index]['userId']['firstName']}',
                            body: '${controller.posts[index]['description']}',
                            isImage:
                                controller.posts[index]['picturePath'] == null
                                    ? false
                                    : true,
                            image: '${controller.posts[index]['picturePath']}',
                            profileImage:
                                '${controller.posts[index]['userId']['picturePath']}',
                            comment:
                                '${controller.posts[index]['comments'].length}',
                            heart: '${controller.posts[index]['likes'].length}',
                            time: '${controller.posts[index]['createdAt']}',
                            currentId: "${controller1.inf[0]['user']['_id']}",
                            id: '${controller.posts[index]['userId']['_id']}',
                            color: myservices.sharedpref.getBool('dark') == true
                                ? const Color(0xFF242526)
                                : Colors.white,
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    );
                  })),

          // Expanded(
          //     child: FutureBuilder(
          //       future: controller0.posts[0],
          //   builder: (context,AsyncSnapshot snapshot) {
          //     if(snapshot.hasData){
          //       // Scroll
          //       return ListView.builder(
          //         controller: controller0.controller1,
          //         itemCount: snapshot.data!['posts'].length,
          //         itemBuilder: (context,i){
          //         return Posts(text: '${snapshot.data['posts'][i]['userId']['firstName']}');
          //       });
          //     }return Text('dfghmhgfhg');
          //   },
          // )),
        ],
      ),
    );
  }
}
