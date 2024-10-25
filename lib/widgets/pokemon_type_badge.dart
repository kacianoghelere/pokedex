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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: HSLColor.fromColor(typeColor).withLightness(0.3).toColor(),
        borderRadius: BorderRadius.circular(16.0)
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: PokemonTypeImage(
              PokemonTypeEnum.parse(type),
              height: 26,
              width: 26
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left : 4.0, right: 8.0),
            child: Text(
              type.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
        ],
      )
    );
  }
}