import 'package:flutter/material.dart';

@immutable
class ContainerDecorationTheme
    extends ThemeExtension<ContainerDecorationTheme> {
  final BoxDecoration mainContainer;

  const ContainerDecorationTheme({
    required this.mainContainer,
  });

  @override
  ContainerDecorationTheme copyWith({BoxDecoration? mainContainer}) {
    return ContainerDecorationTheme(
      mainContainer: mainContainer ?? this.mainContainer,
    );
  }

  @override
  ContainerDecorationTheme lerp(
      ThemeExtension<ContainerDecorationTheme>? other, double t) {
    if (other is! ContainerDecorationTheme) return this;
    return ContainerDecorationTheme(
      mainContainer: BoxDecoration.lerp(mainContainer, other.mainContainer, t)!,
    );
  }
}
