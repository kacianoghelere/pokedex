import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/widgets/nothing_found_indicator.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class PokemonEvolutionsTab extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonEvolutionsTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    if (pokemon.evolutionChain.stages.length == 1) {
      return const NothingFoundIndicator();
    }

    return ListView.builder(
      addRepaintBoundaries: true,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      shrinkWrap: true,
      itemCount: pokemon.evolutionChain.stages.length,
      itemBuilder: (context, index) {
        return PokemonCard(pokemon: pokemon.evolutionChain.stages[index]);
      }
    );
  }
}