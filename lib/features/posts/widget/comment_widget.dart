import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/features/posts/controller/home_screen_controller.dart';

void onCommentPress(item) {
  final HomeScreenController controller = HomeScreenController.to;
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Color(0xFF242526)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFF0a0a0a),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const Expanded(flex: 1, child: CircleAvatar()),
                  Expanded(
                    flex: 3,
                    child: Form(
                      child: TextFormField(
                        controller: controller.commentController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF242526),
                          labelText: 'Write Your Comment  ',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.makeComment(
                            controller.commentController.text, item['_id']);
                      },
                      icon: const Icon(Icons.send)),
                ],
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: item['comments'].length,
              itemBuilder: (context, i) => '${item['comments'].length}' == "0"
                  ? const SizedBox(
                      height: 0,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              maxRadius: 25,
                              backgroundImage: NetworkImage(item['comments'][i]
                                  ['postedBy']['picturePath']),
                              onBackgroundImageError: (exception, stackTrace) =>
                                  print('gfdsdf'),
                            )),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                item['comments'][i]['postedBy']['firstName'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(item['comments'][i]['text'])
                            ],
                          ),
                        ),
                      ],
                    ),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ],
        ),
      ),
    ),
  );
}
