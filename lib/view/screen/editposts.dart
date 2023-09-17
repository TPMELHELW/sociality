import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/controller/editpostcontroller.dart';
import 'package:sociality/controller/infinitiscrollcontroller.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/middleware/middleware.dart';
import 'package:sociality/view/widgets/auth/normalbuttonauth.dart';
import 'package:sociality/view/widgets/homescreen/describtionformfield.dart';

class EditPost extends StatelessWidget {
  final Map controllerScroll;
  const EditPost({super.key, required this.controllerScroll});

  @override
  Widget build(BuildContext context) {
    MyServices myservices = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Post',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<EditPostController>(
          init: EditPostController(),
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.statusrequest == StatusRequest.loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: myservices.sharedpref.getBool('dark') == true
                                ? const Color(0xFF242526)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                  offset: Offset(0, 2),
                                  blurRadius: 1,
                                  spreadRadius: -1),
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.14),
                                  offset: Offset(0, 1),
                                  blurRadius: 1,
                                  spreadRadius: 1),
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.12),
                                  offset: Offset(0, 1),
                                  blurRadius: 3,
                                  spreadRadius: 1)
                            ]),
                        child: Form(
                          key: controller.formState,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                onChanged: (val) {
                                  print('$val');
                                  controller.desc = val;
                                },
                                initialValue: controllerScroll['description'],
                                decoration: InputDecoration(
                                  labelText: 'Edit Your Post',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              NormalButtonAuth(
                                text: 'Edit Post',
                                onpress: () async {
                                  await controller
                                      .editPost(controllerScroll['_id']);
                                },
                              )
                            ],
                          ),
                        ))
              ],
            );
          }),
    );
  }
}
