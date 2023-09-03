import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/homescreencontroller.dart';
import 'package:sociality/controller/infinitiscrollcontroller.dart';
import 'package:sociality/view/widgets/posts.dart';
import 'package:sociality/view/widgets/textappbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // HomeScreenController controller = Get.put(HomeScreenController());
    Scroll controller0 = Get.put(Scroll());

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const TextAppBar(),
        centerTitle: true,
      ),
      body: Column(
        // alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF757575),
                        maxRadius: 25,
                        // minRadius: 30,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "What`s on your mind...",
                            fillColor: const Color(0xFF333333),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: 2.5,
                  color: Color(0xFF363636),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.image),
                      label: const Text('Images'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Share'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: GetBuilder<Scroll>(
                  init: Scroll(),
                  builder: (controller) {
                    return ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.posts.length +
                          (controller.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < controller.posts.length) {
                          // final post = _posts[index];
                          return Posts(
                              text:
                                  '${controller.posts[index]['userId']['firstName']}',
                                  body:'${controller.posts[index]['description']}' ,);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    );
                  })),

          // Expanded(
          //     child: FutureBuilder(
          //       future: controller0.posts[0],
          //   builder: (context,AsyncSnapshot snapshot) {
          //     if(snapshot.hasData){
          //       // Scroll
          //       return ListView.builder(
          //         controller: controller0.controller1,
          //         itemCount: snapshot.data!['posts'].length,
          //         itemBuilder: (context,i){
          //         return Posts(text: '${snapshot.data['posts'][i]['userId']['firstName']}');
          //       });
          //     }return Text('dfghmhgfhg');
          //   },
          // )),
        ],
      ),
    );
  }
}
