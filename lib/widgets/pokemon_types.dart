import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/widgets/pokemon_type_badge.dart';

class PokemonTypes extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonTypes({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: pokemon.types.map((pokemonType) {
        return PokemonTypeBadge(type: pokemonType.type);
      }).toList()
    );
  }
}
