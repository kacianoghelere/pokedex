import 'package:flutter/material.dart';
import 'package:pokedex/utils/extensions/color.dart';

class Theme {
  static const color = Color.fromRGBO(204, 0, 0, 1);

  static const materialColor = color.toMaterialColor();

  static const theme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: color
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: color),
    primarySwatch: materialColor.toMaterialColor()
  );
}