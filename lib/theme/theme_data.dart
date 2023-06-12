import 'package:flex_color_scheme/flex_color_scheme.dart';

class GenshinThemeData {
  static final lightMode = FlexThemeData.light(
    scheme: FlexScheme.amber,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Genshin',
  );

  static final darkMode = FlexThemeData.dark(
    scheme: FlexScheme.amber,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Genshin',
  );
}
