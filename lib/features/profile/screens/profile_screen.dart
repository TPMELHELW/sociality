import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sociality/features/posts/widget/posts_widget.dart';
import 'package:sociality/core/widget/text_app_bar_widget.dart';
import 'package:sociality/features/profile/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
        appBar: const CustomAppBarWidget(
          text: "Sociality",
          isLeading: false,
          isAction: true,
          actionIcon: Icons.arrow_back_ios,
          // onActionPress: () {
          //   // if (controller.isProfile) {
          //   //   controller.onBackTap();
          //   // } else {
          //   //   controller.logOut();
          //   //   Get.offAll(
          //   //     () => const LoginScreen(),
          //   //   );
          //   // }
          // },
        ),
        body: PagedListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, dynamic item, index) {
              return Posts(
                isImage: false,
                item: item,
                index: index,
              ) as Widget;
            },
          ),
        ));
  }
}
