import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociality/utils/middleware/services.dart';

class ContainerShapeWidget extends StatelessWidget {
  final Widget child;
  const ContainerShapeWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find<MyServices>();
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: myServices.sharedpref.getBool('dark') == true
                ? const Color(0xFF242526)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
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
        child: child);
  }
}
