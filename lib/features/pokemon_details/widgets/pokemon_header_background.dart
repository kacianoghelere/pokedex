import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/helpers/pokemon_types_helper.dart';
import 'package:pokedex/widgets/pokemon_sprite.dart';

class PokemonHeaderBackground extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonHeaderBackground({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Image.asset( // TODO: Add sprite zoom
            PokemonTypesHelper.getTypeBackground(pokemon.mainType.type),
            width: MediaQuery.sizeOf(context).width,
            height: 500,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          height: 500,
          width: MediaQuery.sizeOf(context).width,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  pokemon.typeColor,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SizedBox(
              height: 500,
              width: MediaQuery.sizeOf(context).width,
            ),
          )
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48.0),
            child: PokemonSprite(
              pokemon: pokemon,
              size: 240,
            )
          ),
        )
      ],
    );
  }
}