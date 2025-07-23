import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/features/auth/auth_screen.dart';
import 'package:sociality/features/auth/screens/login_screen/login_screen.dart';
import 'package:sociality/features/posts/controller/home_screen_controller.dart';
import 'package:sociality/features/posts/widget/post_view_widget.dart';
import 'package:sociality/features/posts/widget/share_post_view_widget.dart';
import 'package:sociality/core/widget/text_app_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBarWidget(
              text: "Sociality",
              isLeading: false,
              isAction: true,
              actionIcon: controller.isProfile
                  ? Icons.arrow_back_ios
                  : Icons.exit_to_app,
              onActionPress: () {
                if (controller.isProfile) {
                  controller.onBackTap();
                } else {
                  controller.logOut();
                  Get.offAll(
                    () => const LoginScreen(),
                  );
                }
              },
            ),
            body: Column(
              children: [
                controller.isProfile
                    ? const SizedBox()
                    : SharePostViewWidget(controller: controller),
                PostViewWidget(controller: controller)
              ],
            ),
          );
        });
  }
}
