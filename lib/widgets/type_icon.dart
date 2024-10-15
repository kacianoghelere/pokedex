import 'package:flutter/material.dart';
import 'package:pokedex/utils/type_icons.dart';

class TypeIcon extends StatelessWidget {
  final String type;
  final TextStyle? style;

  const TypeIcon({super.key, required this.type, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      getTypeIcon(type),
      style: style != null
        ? style!.copyWith(fontFamily: 'PokeGoTypes')
        : const TextStyle(fontFamily: 'PokeGoTypes')
    );
  }
}
