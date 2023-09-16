import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sociality/view/widgets/homescreen/describtionformfield.dart';
import 'package:sociality/view/widgets/homescreen/posts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Sceen')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            // height: 50,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white, spreadRadius: 5, blurRadius: 20)
                ]),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 25,
                      ),
                    ),
                    // DescribtionField(color: Colors.white, controller: null,)
                    Expanded(
                      flex: 3,
                      child: Form(
                          child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'what`s in your mind...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )),
                    )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.image)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {},
                      child: Text('share'),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(children: [
            // Container(child: ,)
          ]))
        ],
      ),
    );
  }
}
