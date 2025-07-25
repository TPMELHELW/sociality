import 'package:flutter/material.dart';
import 'package:sociality/core/widget/auth_button_widget.dart';
import 'package:sociality/core/widget/container_shape_widget.dart';
import 'package:sociality/features/posts/controller/home_screen_controller.dart';
import 'package:sociality/features/posts/widget/description_field_widget.dart';

class SharePostViewWidget extends StatelessWidget {
  const SharePostViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = HomeScreenController.to;
    return ContainerShapeWidget(
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
                text: "What`s on your mind ..", color: Colors.black,
                // color: controller.myServices.sharedpref.getBool('dark') == true
                //     ? const Color(0xFF242526)
                //     : Colors.white,
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
              ButtonWidget(
                isAuth: false,
                statusRequest: controller.statusRequest,
                onpress: () async => controller.isEditPost
                    ? await controller.editPost()
                    : await controller.sharePost(),
                text: 'Share',
              )
            ],
          ),
        ],
      ),
    );
  }
}
