import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/infinitiscrollcontroller.dart';
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/controller/sharepostscontroller.dart';
import 'package:sociality/controller/themedata.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/middleware/middleware.dart';
import 'package:sociality/view/screen/auth/login.dart';
import 'package:sociality/view/screen/profile.dart';
import 'package:sociality/view/widgets/homescreen/describtionformfield.dart';
import 'package:sociality/view/widgets/homescreen/imagebutton.dart';
import 'package:sociality/view/widgets/homescreen/posts.dart';
import 'package:sociality/view/widgets/homescreen/sharebutton.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // LogInController controller1 = Get.find();
    SharePostsController controller2 = Get.put(SharePostsController());
    ThemeController controller0 = ThemeController();
    MyServices myservices = Get.find();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              myservices.sharedpref.clear();
              Get.offAll(LogIn());
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
        elevation: 0,
        title: TextAppBar(
          text: 'Sociality',
        ),
        centerTitle: true,
      ),
      body: GetBuilder<Scroll>(
        init: Scroll(),
        builder: (controller) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: myservices.sharedpref.getBool('dark') == true
                      ? const Color(0xFF242526)
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: myservices.sharedpref.getBool('dark') == false
                            ? const Color(0xFF242526)
                            : Colors.white,
                        spreadRadius: 2,
                        blurRadius: 20)
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            maxRadius: 25,
                          ),
                        ),
                        DescribtionField(
                          global: controller2.formState,
                          controller: controller2.description,
                          text: "What`s on your mind ..",
                          color: myservices.sharedpref.getBool('dark') == true
                              ? const Color(0xFF242526)
                              : Colors.white,
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 2.5,
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
                    ),
                    IconButton(
                      onPressed: () {
                        controller0.onpress();
                        controller.update();
                      },
                      icon: const Icon(
                        Icons.light,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                controller: controller.scrollController,
                itemCount:
                    controller.posts.length + (controller.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < controller.posts.length) {
                    return Posts(
                      text: '${controller.posts[index]['userId']['firstName']}',
                      body: '${controller.posts[index]['description']}',
                      isImage: controller.posts[index]['picturePath'] == null
                          ? false
                          : true,
                      image: '${controller.posts[index]['picturePath']}',
                      profileImage:
                          '${controller.posts[index]['userId']['picturePath']}',
                      comment: '${controller.posts[index]['comments'].length}',
                      heart: '${controller.posts[index]['likes'].length}',
                      time: '${controller.posts[index]['createdAt']}',
                      currentId: "${myservices.sharedpref.getString('id')}",
                      id: '${controller.posts[index]['userId']['_id']}',
                      color: myservices.sharedpref.getBool('dark') == true
                          ? const Color(0xFF242526)
                          : Colors.white,
                      controller: controller.posts[index],
                    );
                  } else {
                    return Center(
                      child: const CircularProgressIndicator(),
                    );
                  }
                },
              )),
            ],
          );
        },
      ),
    );
  }
}
