// import 'package:flutter/material.dart';

// class PostType extends StatelessWidget {
//   const PostType({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1a1a1a),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         children: [
//           Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               const Expanded(
//                 flex: 1,
//                 child: CircleAvatar(
//                   backgroundColor: Color(0xFF757575),
//                   maxRadius: 25,
//                   // minRadius: 30,
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Form(
//                   key: controller2.formState,
//                   child: TextFormField(
//                     controller: controller2.description,
//                     decoration: InputDecoration(
//                         hintText: "What`s on your mind...",
//                         fillColor: const Color(0xFF333333),
//                         filled: true,
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(50))),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           const Divider(
//             thickness: 2.5,
//             color: Color(0xFF363636),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.image),
//                 label: const Text('Images'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   // controller.isMore = true;
//                   // controller.update();
//                   // await controller2.postData();
//                   // // Get.delete<Scroll>();
//                   // controller.update();
//                   // // controller.dispose();
//                   // // controller.onDelete();
//                   // await controller.fetchData();
//                   // controller.isMore = false;
//                   // controller.update();
//                 },
//                 child: const Text('Share'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(50, 40),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
