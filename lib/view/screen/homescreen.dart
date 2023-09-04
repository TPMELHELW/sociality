import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/infinitiscrollcontroller.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/controller/sharepostscontroller.dart';
import 'package:sociality/view/widgets/posts.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scroll controller0 = Get.put(Scroll());
    LogInController controller1 = Get.find();
    SharePostsController controller2 = Get.put(SharePostsController());
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const TextAppBar(),
        centerTitle: true,
      ),
      body: GetBuilder<Scroll>(
        init: Scroll(),
        builder: (controller) => Column(
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
                        child: Form(
                          key: controller2.formState,
                          child: TextFormField(
                            controller: controller2.description,
                            decoration: InputDecoration(
                                hintText: "What`s on your mind...",
                                fillColor: const Color(0xFF333333),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          ),
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
                        onPressed: () async {
                          controller.isMore = true;
                          controller.update();
                          await controller2.postData();
                          Get.delete<Scroll>();
                          controller.update();
                          // controller.dispose();
                          // controller.onDelete();
                          // controller.fetchData();
                          controller.isMore = false;
                          controller.update();
                        },
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
              child: controller.isMore == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      // reverse: true,
                      controller: controller.scrollController,
                      itemCount: controller.posts.length +
                          (controller.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < controller.posts.length) {
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
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}




// ListView.builder(
//                               controller: controller.scrollController,
//                               itemCount: controller.posts.length +
//                                   (controller.isLoading ? 1 : 0),
//                               itemBuilder: (context, index) {
//                                 if (index < controller.posts.length) {
//                                   return Posts(
//                                     text:
//                                         '${controller.posts[index]['userId']['firstName']}',
//                                     body:
//                                         '${controller.posts[index]['description']}',
//                                     isImage: controller.posts[index]
//                                                 ['picturePath'] ==
//                                             null
//                                         ? false
//                                         : true,
//                                     image:
//                                         '${controller.posts[index]['picturePath']}',
//                                     profileImage:
//                                         '${controller.posts[index]['userId']['picturePath']}',
//                                     comment:
//                                         '${controller.posts[index]['comments'].length}',
//                                     heart:
//                                         '${controller.posts[index]['likes'].length}',
//                                     time:
//                                         '${controller.posts[index]['createdAt']}',
//                                     currentId:
//                                         "${controller1.inf[0]['user']['_id']}",
//                                     id: '${controller.posts[index]['userId']['_id']}',
//                                   );
//                                 } else {
//                                   return const Center(
//                                       child: CircularProgressIndicator());
//                                 }
//                               },
//                             ),