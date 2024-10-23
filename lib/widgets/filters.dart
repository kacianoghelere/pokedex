import 'package:flutter/material.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/widgets/pokemon_generations_filter.dart';
import 'package:pokedex/widgets/pokemon_types_filter.dart';
import 'package:provider/provider.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350, // Set your desired height
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Filters',
              style: Theme.of(context).textTheme.titleLarge
            ),
            const SizedBox(height: 16),
            const PokemonGenerationsFilter(),
            const SizedBox(height: 16),
            const PokemonTypesFilter(),
            const SizedBox(height: 16),
            Consumer2<PokemonProvider, FilterProvider>(
              builder: (context, pokemonProvider, filterProvider, _) {
                return Row(
                  children: [
                    FilledButton(
                      onPressed: () {
                        pokemonProvider.fetchPokemons(
                          generations: filterProvider.selectedGenerations,
                          pokemonTypes: filterProvider.selectedTypes
                        );
                      },
                      child: const Text('Apply filters'),
                    ),
                    const SizedBox(width: 4),
                    FilledButton.tonal(
                      onPressed: () {
                        filterProvider.clearFilters();

                        pokemonProvider.fetchPokemons(
                          generations: [],
                          pokemonTypes: []
                        );
                      },
                      child: const Text('Clear')
                    ),
                  ],
                );
              }
            )
          ],
        ),
      )
    );
  }
}
