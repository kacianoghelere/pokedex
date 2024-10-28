import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pokedex/models/pokemon_generation.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/widgets/pokemon_type_icon.dart';
import 'package:provider/provider.dart';

class PokemonFiltersButton extends StatefulWidget {
  const PokemonFiltersButton({super.key});

  @override
  State<PokemonFiltersButton> createState() => _PokemonFiltersButtonState();
}

class _PokemonFiltersButtonState extends State<PokemonFiltersButton> {
  Timer? _generationsFilterDebouncer;
  Timer? _typesFilterDebouncer;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      overlayOpacity: 0.5,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      tooltip: 'Filters',
      children: [
        _buildSpeedDialChild(
          isDarkMode: themeProvider.isDarkMode,
          child: const Icon(Icons.onetwothree_rounded),
          label: 'Generations',
          onTap: () => _openGenerationFilter(context)
        ),
        _buildSpeedDialChild(
          isDarkMode: themeProvider.isDarkMode,
          child: const Icon(Icons.energy_savings_leaf_sharp),
          label: 'Types',
          onTap: () => _openTypeFilter(context)
        ),
      ],
    );
  }

  SpeedDialChild _buildSpeedDialChild({
    required bool isDarkMode,
    required String label,
    required void Function() onTap,
    Widget? child,
  }) {
    return SpeedDialChild(
      backgroundColor: Theme.of(context).primaryColor,
      child: child,
      foregroundColor: isDarkMode ? Colors.white : Colors.black,
      label: label,
      labelBackgroundColor: isDarkMode ? Colors.black : Colors.white,
      labelShadow: [],
      labelStyle: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black
      ),
      onTap: onTap,
      shape: const CircleBorder()
    );
  }

  void _openGenerationFilter(BuildContext context) {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
      context: context,
      isDismissible: true,
      builder: (context) {
        final filterProvider = Provider.of<FilterProvider>(context);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              const _BottomSheetHeader(title: 'Pokemon Generations'),
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3,
                ),
                itemCount: filterProvider.generations.length,
                itemBuilder: (context, index) {
                  final generation = filterProvider.generations[index];

                  return FilterChip(
                    elevation: 1,
                    showCheckmark: false,
                    padding: EdgeInsets.zero,
                    selected: filterProvider.selectedGenerations.contains(generation),
                    label: Center(
                      child: Text(generation.name),
                    ),
                    onSelected: (_) => _toggleGenerationSelection(generation)
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleGenerationSelection(PokemonGeneration generation) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    filterProvider.toggleGenerationSelection(generation);
    
    if ((_generationsFilterDebouncer?.isActive ?? false)) {
      _generationsFilterDebouncer?.cancel();
    }
    
    _generationsFilterDebouncer = Timer(Durations.long4, () {
      Provider.of<PokemonProvider>(context, listen: false)
        .fetchPokemons(
          generations: filterProvider.selectedGenerations,
          pokemonTypes: filterProvider.selectedTypes
        );
    });
  }

  void _openTypeFilter(BuildContext context) {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
      context: context,
      isDismissible: true,
      builder: (context) {
        final filterProvider = Provider.of<FilterProvider>(context);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              const _BottomSheetHeader(title: 'Pokemon Types'),
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.3,
                ),
                itemCount: filterProvider.types.length,
                itemBuilder: (context, index) {
                  final pokemonType = filterProvider.types[index];

                  return FilterChip(
                    showCheckmark: false,
                    padding: const EdgeInsets.all(8),
                    selected: filterProvider.selectedTypes.contains(pokemonType),
                    label: Center(
                      child: Column(
                        children: [
                          PokemonTypeImage(
                            PokemonTypeEnum.parse(pokemonType.type),
                            height: 30,
                            width: 30
                          ),
                          Text(pokemonType.name)
                        ],
                      ),
                    ),
                    onSelected: (_) => _toggleTypeSelection(pokemonType)
                  );
                }
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleTypeSelection(PokemonType type) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    filterProvider.toggleTypeSelection(type);

    if ((_typesFilterDebouncer?.isActive ?? false)) {
      _typesFilterDebouncer?.cancel();
    }

    _typesFilterDebouncer = Timer(Durations.long4, () {
      Provider.of<PokemonProvider>(context, listen: false)
        .fetchPokemons(
          generations: filterProvider.selectedGenerations,
          pokemonTypes: filterProvider.selectedTypes
        );
    });
  }
}

class _BottomSheetHeader extends StatelessWidget {
  final String title;

  const _BottomSheetHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return SliverAppBar(
      backgroundColor: themeData.bottomSheetTheme.backgroundColor,
      expandedHeight: 50.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        title: Text(
          title,
          style: themeData.textTheme.titleMedium
        ),
      ),
      foregroundColor: themeData.textTheme.titleMedium!.color,
      pinned: true,
    );
  }
}
