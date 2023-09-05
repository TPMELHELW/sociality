// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:sociality/controller/infinitiscrollcontroller.dart';
// import 'package:sociality/controller/logincontroller.dart';

// class Test1 extends StatelessWidget {
//   const Test1({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Scroll controller = Get.put(Scroll());
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Infinite Scroll Example'),
//         ),
//         body: GetBuilder<Scroll>(
//           init: Scroll(),
//           builder: (controller) {
//           return ListView.builder(
//             controller: controller.scrollController,
//             itemCount: controller.posts.length + (controller.isLoading ? 1 : 0),
//             itemBuilder: (context, index) {
//               if (index < controller.posts.length) {
//                 // final post = _posts[index];
//                 return Container(
//                   height: 500,
//                   child: ListTile(
//                     title: Text(controller.posts[index]['userId']['firstName']),
//                     subtitle:
//                         Text(controller.posts[index]['userId']['firstName']),
//                   ),
//                 );
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           );
//         }));
//   }
// }

// // int _page = 0;
// //   bool _isLoading = false;
// //   bool _hasNextPage = true;
// //   List<dynamic> _posts = [];
// //   LogInController controller = Get.put(LogInController());
// //   ScrollController _scrollController = ScrollController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _scrollController.addListener(_scrollListener);
// //     _fetchData();
// //   }

// //   @override
// //   void dispose() {
// //     _scrollController.removeListener(_scrollListener);
// //     _scrollController.dispose();
// //     super.dispose();
// //   }

// //   void _scrollListener() {
// //     if (!_isLoading &&
// //         _scrollController.position.pixels ==
// //             _scrollController.position.maxScrollExtent) {
// //       _fetchData();
// //     }
// //   }

// //   Future<void> _fetchData() async {
// //     if (_isLoading || !_hasNextPage) {
// //       return;
// //     }

// //     setState(() {
// //       _isLoading = true;
// //     });

// //     try {
// //       // final url = "https://example.com/posts?page=$_page";
// //       final response = await http.get(
// //           Uri.parse(
// //               "https://social-medai-mern-b696.vercel.app/posts?page=$_page"),
// //           headers: {
// //             'Authorization': 'Bearer ${controller.inf[0]['accessToken']}',
// //           });
// //       final data = json.decode(response.body);
// //       print(data);
// //       setState(() {
// //         _posts.addAll(data['posts']);
// //         _page++;
// //         print(_posts);
// //         _hasNextPage = data['hasNextPage'];
// //         _isLoading = false;
// //       });
// //     } catch (e) {
// //       setState(() {
// //         _isLoading = false;
// //       });
// //       print('Error: $e');
// //     }
// //   }
