import 'package:flutter/material.dart';
import 'package:get/get.dart';

void onCommentPress(item) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(flex: 1, child: CircleAvatar()),
                Expanded(
                  flex: 3,
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Write Your Comment  ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(40, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Comment'),
                )
              ],
            ),
            ListView.separated(
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
