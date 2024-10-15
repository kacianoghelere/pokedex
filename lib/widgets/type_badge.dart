import 'package:flutter/material.dart';
import 'package:pokedex/utils/type_colors.dart';
import 'package:pokedex/widgets/type_icon.dart';

class TypeBadge extends StatelessWidget {
  final String type;

  const TypeBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Color typeColor = getTypeColor(type);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // decoration: const BoxDecoration(
          //   borderRadius: BorderRadius.only(
          //     bottomLeft: Radius.circular(2),
          //     topLeft: Radius.circular(2)
          //   ),
          // ),
          color: typeColor,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: TypeIcon(type: type),
        ),
        Container(
          color: HSLColor.fromColor(typeColor).withLightness(0.15).toColor(),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Text(
            type.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )
          )
        )
      ],
    );
  }
}