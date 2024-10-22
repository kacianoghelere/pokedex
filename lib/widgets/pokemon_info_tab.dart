import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/widgets/pokemon_abilities.dart';
import 'package:pokedex/widgets/pokemon_basic_info.dart';
import 'package:pokedex/widgets/pokemon_stats.dart';
import 'package:pokedex/widgets/pokemon_types.dart';

class PokemonInfoTab extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonInfoTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              pokemon.description,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontStyle: FontStyle.italic
              )
            ),
          ),
          PokemonTypes(pokemon: pokemon),
          PokemonBasicInfo(pokemon: pokemon),
          const SizedBox(height: 16),
          PokemonStats(pokemon: pokemon),
          const SizedBox(height: 16),
          PokemonAbilities(pokemon: pokemon)
        ]
      )
    );
  }
}