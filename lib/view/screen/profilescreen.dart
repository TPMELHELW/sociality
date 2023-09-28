import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/profilescreencontroller.dart';
import 'package:sociality/middleware/middleware.dart';
import 'package:sociality/view/widgets/homescreen/posts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myservices = Get.find();
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed('/homescreen');
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Profile Screen'),
            leading: IconButton(
                onPressed: () {
                  Get.offAllNamed('/homescreen');
                },
                icon: const Icon(Icons.backup_sharp)),
          ),
          body: GetBuilder<ProfileScreenController>(
              init: ProfileScreenController(),
              builder: (controller) {
                return ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.posts.length +
                        (controller.isLoading ? 1 : 0),
                    itemBuilder: (context, i) {
                      if (i < controller.posts.length) {
                        return Posts(
                          text: '${controller.posts[i]['userId']['firstName']}',
                          body: '${controller.posts[i]['description']}',
                          isImage: controller.posts[i]['picturePath'] == null
                              ? false
                              : true,
                          image: '${controller.posts[i]['picturePath']}',
                          profileImage:
                              '${controller.posts[i]['userId']['picturePath']}',
                          comment: '${controller.posts[i]['comments'].length}',
                          heart: '${controller.posts[i]['likes'].length}',
                          time: '${controller.posts[i]['createdAt']}',
                          currentId: "${myservices.sharedpref.getString('id')}",
                          id: '${controller.posts[i]['userId']['_id']}',
                          color: myservices.sharedpref.getBool('dark') == true
                              ? const Color(0xFF242526)
                              : Colors.white,
                          controller: controller.posts[i],
                          textComment: controller.posts[i]['comments'],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              })),
    );
  }
}
