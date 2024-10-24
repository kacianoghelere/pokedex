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
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: filterProvider.generations.length,
        itemBuilder: (context, index) {
          final generation = filterProvider.generations[index];

          final isSelected = filterProvider.selectedGenerations.contains(generation);

          return Expanded(
            child: FilterChip(
              label: Text(generation.name),
              selected: isSelected,
              onSelected: (selected) {
                filterProvider.setGenerationIds(
                  selected
                    ? [...filterProvider.selectedGenerations, generation]
                    : filterProvider.selectedGenerations..remove(generation),
                );
              },
            ),
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
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: filterProvider.types.length,
        itemBuilder: (context, index) {
          final type = filterProvider.types[index];

          final isSelected = filterProvider.selectedTypes.contains(type);

          return FilterChip(
            label: PokemonTypeImage(
              PokemonTypeEnum.parse(type.name),
              height: 26,
              width: 26
            ),
            selected: isSelected,
            onSelected: (selected) {
              filterProvider.setTypes(
                selected
                    ? [...filterProvider.selectedTypes, type]
                    : filterProvider.selectedTypes..remove(type),
              );
            },
          );
        },
      );
    },
  );
}