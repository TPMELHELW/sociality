// // main.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:sociality/controller/logincontroller.dart';

// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   LogInController controller = Get.find();
//   // The page number for pagination
//   int _page = 0;

//   // The limit for each page
//   int _limit = 10;

//   // The total number of pages
//   // int _totalPages = 0;

//   // The controller for scrolling
//   ScrollController _scrollController = ScrollController();

//   // The list of posts
//   List _posts = [];

//   // The future for fetching posts
//   Future _fetchPosts() async {
//     // he API endpoint for fetching posts
//     String url = "https://social-medai-mern-b696.vercel.app/posts?page=$_page";

//     // Send a GET request to the API
//     var response = await http.get(Uri.parse(url), headers: {
//       'Authorization': 'Bearer ${controller.inf[0]['accessToken']}',
//     });
//     // print("$response *---*-*-*-*-*---*");
//     // Get the total number of pages from the response headers
//     // _totalPages =
//     //     (int.parse(response.headers['x-total-count']!) ).ceil();

//     // Decode the response body as JSON
//     var data = jsonDecode(response.body);
//     // print(data); // Convert the JSON data to a list of posts
//     // List<Post> posts = data.map<Post>((post) => Post.fromJson(post)).toList();
//     // print(posts);
//     // Return the list of posts
//     return data['posts'];
//   }

//   @override
//   void initState() {
//     super.initState();

//     // Add a listener to the scroll controller
//     _scrollController.addListener(() {
//       // Check if the user has reached the end of the list
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         // Check if there are more pages to load
//         if (_page < _totalPages) {
//           // Increment the page number and call setState to trigger a rebuild
//           setState(() {
//             _page++;
//           });
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // Dispose the scroll controller
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FutureBuilder(
//           future: _fetchPosts(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               // print(snapshot.data);
//               // Append the new posts to the existing list
//               _posts.addAll(snapshot.data!);

//               return ListView.builder(
//                 controller: _scrollController,
//                 itemCount: _posts.length + (_page < _totalPages ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index == _posts.length) {
//                     // Show a loading indicator at the end of the list
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else {
//                     // Show a post card for each post
//                     return Card(
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           child: Text('${_posts[index]['userId']['firstName']}'),
//                         ),
//                         // title: Text(_posts[index].title),
//                         // subtitle: Text(_posts[index].body),
//                       ),
//                     );
//                   }
//                 },
//               );
//             } else if (snapshot.hasError) {
//               // Show an error message if something goes wrong
//               return Center(
//                 child: Text(snapshot.error.toString()),
//               );
//             } else {
//               // Show a loading indicator while waiting for the data
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

