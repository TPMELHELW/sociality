import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/infinitiscrollcontroller.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/controller/sharepostscontroller.dart';
import 'package:sociality/controller/themedata.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/view/widgets/homescreen/describtionformfield.dart';
import 'package:sociality/view/widgets/homescreen/imagebutton.dart';
import 'package:sociality/view/widgets/homescreen/posts.dart';
import 'package:sociality/view/widgets/homescreen/sharebutton.dart';
import 'package:sociality/view/widgets/homescreen/themebutton.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LogInController controller1 = Get.find();
    SharePostsController controller2 = Get.put(SharePostsController());
    ThemeController controller = Get.put(ThemeController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              controller.onpress();
            },
            icon: const Icon(
              Icons.light,
              color: Colors.black,
            ),
          ),
        ],
        title: const TextAppBar(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? const Color(0xFF1a1a1a) : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF757575),
                        maxRadius: 25,
                      ),
                    ),
                    DescribtionField(
                      global: controller2.formState,
                      controller: controller2.description,
                      text:
                          "What`s on your mind ${controller1.inf[0]['user']['firstName']}",
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
                    const ImageButton(),
                    ShareButton(
                      onpress: () async {
                        await controller2.postData();
                        Get.offAll(() => const HomeScreen());
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          GetBuilder<Scroll>(
            init: Scroll(),
            builder: (controller) => Expanded(
              child: controller.statusRequest == StatusRequest.success
                  ? ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.posts.length +
                          (controller.statusRequest == StatusRequest.success
                              ? 0
                              : 1),
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
                          Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          )
        ],
      ),
    );
  }
}


// ListView.builder(
//                       controller: controller.scrollController,
//                       itemCount: controller.posts.length +
//                           (controller.isLoading ? 1 : 0),
//                       itemBuilder: (context, index) {
//                         if (index < controller.posts.length) {
//                           return Posts(
//                             text:
//                                 '${controller.posts[index]['userId']['firstName']}',
//                             body: '${controller.posts[index]['description']}',
//                             isImage:
//                                 controller.posts[index]['picturePath'] == null
//                                     ? false
//                                     : true,
//                             image: '${controller.posts[index]['picturePath']}',
//                             profileImage:
//                                 '${controller.posts[index]['userId']['picturePath']}',
//                             comment:
//                                 '${controller.posts[index]['comments'].length}',
//                             heart: '${controller.posts[index]['likes'].length}',
//                             time: '${controller.posts[index]['createdAt']}',
//                             currentId: "${controller1.inf[0]['user']['_id']}",
//                             id: '${controller.posts[index]['userId']['_id']}',
//                           );
//                         } else {
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         }
//                       },
//                     ),
