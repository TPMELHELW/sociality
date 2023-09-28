import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final List textComment;
  final String comment;
  const Comment({super.key, required this.textComment, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: textComment.length,
      itemBuilder: (context, i) => comment == "0"
          ? const SizedBox(
              height: 0,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(),
                Text(textComment[i]['text']),
              ],
            ),
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
