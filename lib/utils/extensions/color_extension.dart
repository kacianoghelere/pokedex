import 'package:flutter/material.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:provider/provider.dart';

extension ColorExtension on Color {
  MaterialColor toMaterialColor() {
    final int red = this.red;
    final int green = this.green;
    final int blue = this.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(value, shades);
  }

  Color get darkVariant {
    return HSLColor.fromColor(this).withLightness(0.4).toColor();
  }

  Color get lightVariant {
    return HSLColor.fromColor(this).withLightness(0.8).toColor();
  }

  Color getColorByThemeMode(BuildContext context) {
    final ThemeMode themeMode = Provider.of<ThemeProvider>(context).mode;

    return switch(themeMode) {
      ThemeMode.dark => darkVariant,
      ThemeMode.light => lightVariant,
      _ => lightVariant
    };
  }
}