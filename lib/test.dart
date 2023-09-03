import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sociality/controller/logincontroller.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  // final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  int _page = 0;
  LogInController controller = Get.put(LogInController());
  // final int _limit = 20;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;

  List _posts = [];

 void _loadMore() async {
  if (_hasNextPage == true &&
      _isFirstLoadRunning == false &&
      _isLoadMoreRunning == false &&
      _controller.position.extentAfter < 300) {
    setState(() {
      _isLoadMoreRunning = true; // Display a progress indicator at the bottom
    });

    _page += 1; // Increase _page by 1

    try {
      final res = await http.get(
          Uri.parse("https://social-medai-mern-b696.vercel.app/posts?page=$_page"),
          headers: {
            'Authorization': 'Bearer ${controller.inf[0]['accessToken']}',
          });

      var fetchedPosts = json.decode(res.body);
      print(fetchedPosts);
      if (fetchedPosts.isNotEmpty) {
        setState(() {
          _posts.addAll(fetchedPosts['posts']); // Append the fetched posts to the existing list
        });
      } else {
        setState(() {
          _hasNextPage = false;
        });
      }
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong!');
      }
      print(err);
    }

    setState(() {
      _isLoadMoreRunning = false;
    });
  }
}

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res = await http.get(
          Uri.parse(
              "https://social-medai-mern-b696.vercel.app/posts?page=$_page"),
          headers: {
            'Authorization': 'Bearer ${controller.inf[0]['accessToken']}',
          });
      setState(() {
        var respncebody = json.decode(res.body);
        _posts.add(respncebody);
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
      print(err);
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your news',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _posts[0]['posts'].length,
                      controller: _controller,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: Container(
                          height: 500,
                          child: ListTile(
                            title: Text(
                                _posts[0]['posts'][index]['userId']['firstName']),
                            subtitle: Text(
                                _posts[0]['posts'][index]['userId']['firstName']),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_isLoadMoreRunning == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (_hasNextPage == false)
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 40),
                      color: Colors.amber,
                      child: const Center(
                        child: Text('You have fetched all of the content'),
                      ),
                    ),
                ],
              ));
  }
}
