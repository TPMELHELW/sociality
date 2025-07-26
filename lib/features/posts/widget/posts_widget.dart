import 'package:flutter/material.dart';
import 'package:sociality/core/widget/container_shape_widget.dart';
import 'package:sociality/features/posts/widget/footer_post_widget.dart';
import 'package:sociality/features/posts/widget/header_post_widget.dart';

class Posts extends StatelessWidget {
  final bool isImage;
  final Map item;
  final int index;
  const Posts({
    super.key,
    required this.isImage,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerShapeWidget(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderPostWidget(
              item: item,
              index: index,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${item['description']}',
                textAlign: TextAlign.left,
              ),
            ),
            if (isImage == true)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    '${item['picturePath']}',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const SizedBox(
                height: 0,
              ),
            FooterPostWidget(
              item: item,
            )
          ],
        ));
  }
}
