import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sociality/controller/profile_screen_controller.dart';
import 'package:sociality/middleware/services.dart';
import 'package:sociality/view/widgets/homescreen/posts_widget.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MyServices myservices = Get.find();
    ProfileScreenController controller = Get.put(ProfileScreenController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const TextAppBar(
          text: 'Sociality',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PagedListView(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                animateTransitions: true,
                itemBuilder: (context, dynamic item, index) {
                  return Posts(
                    isImage: false,
                    currentId: "${myservices.sharedpref.getString('id')}",
                    color: myservices.sharedpref.getBool('dark') == true
                        ? const Color(0xFF242526)
                        : Colors.white,
                    item: controller.posts[index],
                    controller: controller,
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
