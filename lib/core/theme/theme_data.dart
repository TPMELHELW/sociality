import 'package:flutter/material.dart';
import 'package:sociality/core/theme/container_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      ContainerDecorationTheme(
        mainContainer: BoxDecoration(
            color: const Color(0xFF242526),
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
      ),
    ],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: const Color(0xFF0a0a0a),
  );

  static ThemeData customLightTheme = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      ContainerDecorationTheme(
        mainContainer: BoxDecoration(
            color: Colors.white,
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
      ),
    ],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: const Color(0xFFf6f6f6),
  );
}
