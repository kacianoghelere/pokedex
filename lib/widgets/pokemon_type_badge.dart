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

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Container(
            decoration: BoxDecoration(
              color: HSLColor.fromColor(typeColor).withLightness(0.3).toColor(),
              borderRadius: BorderRadius.circular(4.0)
            ),
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Text(
                type.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )
              ),
            )
          ),
        ),
        Positioned(
          left: 0,
          top: 5,
          child: PokemonTypeImage(
            PokemonTypeEnum.parse(type),
            height: 26,
            width: 26
          )
        )
      ]
    );
  }
}