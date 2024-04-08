import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, i) => Column(
          children: [
            Form(
              child: TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
