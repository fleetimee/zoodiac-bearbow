import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class GenshinThemeData {
  static final _textTheme = TextTheme(
    titleLarge: const TextStyle(
      fontSize: 18,
    ),
    headlineSmall: const TextStyle(
      fontSize: 22,
    ),
    headlineMedium: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: Colors.grey[800],
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 15,
      color: Colors.grey[400],
      fontWeight: FontWeight.w400,
    ),
  );

  static final lightMode = FlexThemeData.light(
    scheme: FlexScheme.amber,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Genshin',
    textTheme: _textTheme,
  );

  static final darkMode = FlexThemeData.dark(
    scheme: FlexScheme.amber,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Genshin',
    textTheme: _textTheme,
  );
}
