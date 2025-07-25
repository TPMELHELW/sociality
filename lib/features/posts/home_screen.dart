import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/core/routes/app_routes.dart';
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
    final HomeScreenController controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: CustomAppBarWidget(
        text: "Sociality",
        isLeading: false,
        isAction: true,
        actionIcon: Icons.exit_to_app,
        onActionPress: () {
          controller.logOut();
          Get.offAllNamed(AppRoutes.loginScreen);
        },
      ),
      body: const Column(
        children: [SharePostViewWidget(), PostViewWidget()],
      ),
    );
  }
}
