import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/widgets/pokemon_list.dart';

class PokemonEvolutionsTab extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonEvolutionsTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return PokemonList(
      pokemons: pokemon.evolutionChain.stages,
      shrinkWrap: true,
    );
  }
}