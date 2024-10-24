import 'package:flutter/material.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/widgets/pokemon_type_icon.dart';
import 'package:provider/provider.dart';

void openGenerationFilter(BuildContext context) {
  final filterProvider = Provider.of<FilterProvider>(context, listen: false);

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.8,
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: filterProvider.generations.length,
        itemBuilder: (context, index) {
          final generation = filterProvider.generations[index];

          final isSelected = filterProvider.selectedGenerations.contains(generation);

          return FilterChip(
            label: Center(
              child: Text(generation.name)
            ),
            selected: isSelected,
            onSelected: (selected) {
              filterProvider.setGenerationIds(
                selected
                  ? [...filterProvider.selectedGenerations, generation]
                  : filterProvider.selectedGenerations..remove(generation),
              );
            },
          );
        },
      );
    },
  );
}

void openTypeFilter(BuildContext context) {
  final filterProvider = Provider.of<FilterProvider>(context, listen: false);

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.8,
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: filterProvider.types.length,
        itemBuilder: (context, index) {
          final pokemonType = filterProvider.types[index];

          final isSelected = filterProvider.selectedTypes.contains(pokemonType);

          return FilterChip(
            padding: const EdgeInsets.all(8),
            selected: isSelected,
            label: Center(
              child: Column(
                children: [
                  PokemonTypeImage(
                    PokemonTypeEnum.parse(pokemonType.type),
                    height: 26,
                    width: 26
                  ),
                  Text(pokemonType.name)
                ],
              ),
            ),
            onSelected: (selected) {
              filterProvider.setTypes(
                selected
                  ? [...filterProvider.selectedTypes, pokemonType]
                  : filterProvider.selectedTypes..remove(pokemonType),
              );
            },
          );
        },
      );
    },
  );
}