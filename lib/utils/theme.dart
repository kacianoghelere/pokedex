import 'package:flutter/material.dart';
import 'package:pokedex/utils/extensions/color_extension.dart';

class Theme {
  static const primaryColor = Color.fromRGBO(204, 0, 0, 1);

  static final materialColor = primaryColor.toMaterialColor();

  static final theme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    primarySwatch: materialColor.toMaterialColor()
  );
}