import 'package:flutter/material.dart';
import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/utils/pokemon_type_colors.dart';
import 'package:pokedex/widgets/pokemon_type_icon.dart';

class PokemonTypeBadge extends StatelessWidget {
  final String type;

  const PokemonTypeBadge({super.key, required this.type});

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
          child: PokemonTypeImage(
            PokemonTypeEnum.parse(type),
            height: 20,
            width: 20
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: HSLColor.fromColor(typeColor).withLightness(0.3).toColor(),
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