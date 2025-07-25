import 'package:flutter/material.dart';
import 'package:sociality/core/theme/container_theme.dart';

class ContainerShapeWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  const ContainerShapeWidget({super.key, required this.child, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: const EdgeInsets.all(10),
        decoration: Theme.of(context)
            .extension<ContainerDecorationTheme>()!
            .mainContainer,
        child: child);
  }
}
