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
          decoration: BoxDecoration(
            color: typeColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4),
              topLeft: Radius.circular(4)
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: TypeIcon(
            type: type,
            style: const TextStyle(color: Colors.black)
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: HSLColor.fromColor(typeColor).withLightness(0.15).toColor(),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(4),
              topRight: Radius.circular(4)
            ),
          ),
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