import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sociality/controller/home_screen_controller.dart';
import 'package:sociality/view/screen/auth/auth_screen.dart';
import 'package:sociality/view/widgets/homescreen/description_field_widget.dart';
import 'package:sociality/view/widgets/homescreen/posts_widget.dart';
import 'package:sociality/view/widgets/homescreen/sharebutton.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              controller.myServices.sharedpref.clear();
              await controller.logOut();
              Get.offAll(
                () => const AuthScreen(
                  isLogin: true,
                ),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
        elevation: 0,
        title: const TextAppBar(
          text: 'Sociality',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: controller.myServices.sharedpref.getBool('dark') == true
                  ? const Color(0xFF242526)
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                    color: controller.myServices.sharedpref.getBool('dark') ==
                            false
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
                      global: controller.formState,
                      controller: controller.descriptionController,
                      text: "What`s on your mind ..",
                      color: controller.myServices.sharedpref.getBool('dark') ==
                              true
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
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.image),
                      label: const Text('Images'),
                    ),
                    ShareButton(
                      onpress: () async {
                        await controller.postData();
                        Get.delete<HomeScreenController>();
                        Get.offAll(
                          () => const HomeScreen(),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: PagedListView(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                animateTransitions: true,
                itemBuilder: (context, dynamic item, index) {
                  return Posts(
                    controller: controller,
                    isImage: false,
                    currentId:
                        "${controller.myServices.sharedpref.getString('id')}",
                    color:
                        controller.myServices.sharedpref.getBool('dark') == true
                            ? const Color(0xFF242526)
                            : Colors.white,
                    item: controller.posts[index],
                  ) as Widget;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
