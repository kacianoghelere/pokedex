import 'package:flutter/material.dart';
import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/utils/helpers/pokemon_types_helper.dart';
import 'package:pokedex/widgets/pokemon_type_icon.dart';

class PokemonTypeBadge extends StatelessWidget {
  final String type;

  const PokemonTypeBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Color typeColor = PokemonTypesHelper.getTypeColor(type);

    HSLColor hslColor = HSLColor.fromColor(typeColor);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: hslColor.withLightness(0.3).toColor(),
        borderRadius: BorderRadius.circular(16.0)
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: PokemonTypeImage(
              PokemonTypeEnum.parse(type),
              height: 24,
              width: 24
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left : 4.0, right: 8.0),
            child: Text(
              type.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
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