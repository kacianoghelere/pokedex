import 'package:flutter/material.dart';
import 'package:pokedex/utils/type_icons.dart';

class TypeIcon extends StatelessWidget {
  final String type;

  const TypeIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Text(
      getTypeIcon(type),
      style: const TextStyle(fontFamily: 'PokeGoTypes')
    );
  }
}
