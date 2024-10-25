import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/widgets/pokemon_type_icon.dart';
import 'package:provider/provider.dart';

class PokemonListFiltersButton extends StatefulWidget {
  const PokemonListFiltersButton({super.key});

  @override
  State<PokemonListFiltersButton> createState() => _PokemonListFiltersButtonState();
}

class _PokemonListFiltersButtonState extends State<PokemonListFiltersButton> {
  Timer? _generationsFilterDebouncer;
  Timer? _typesFilterDebouncer;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          overlayColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
          overlayOpacity: 0.5,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          tooltip: 'Filters',
          children: [
            SpeedDialChild(
              backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
              foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
              child: const Icon(Icons.onetwothree_rounded),
              label: 'Generations',
              labelBackgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
              labelShadow: [],
              labelStyle: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              onTap: () {
                _openGenerationFilter(context);
              }
            ),
            SpeedDialChild(
              backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
              foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
              child: const Icon(Icons.energy_savings_leaf_sharp),
              label: 'Types',
              labelShadow: [],
              labelStyle: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black
              ),
              labelBackgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
              onTap: () {
                _openTypeFilter(context);
              }
            ),
          ],
        );
      },
    );
  }

  void _openGenerationFilter(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (context) {
        return Consumer<FilterProvider>(
          builder: (context, filterProvider, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomScrollView(
                slivers: [
                  _getBottomSheetHeader('Pokemon Generations'),
                  SliverGrid.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
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
                        onSelected: (_) {
                          Provider.of<FilterProvider>(context, listen: false)
                            .toggleGenerationSelection(generation);

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
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  void _openTypeFilter(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (context) {
        return Consumer<FilterProvider>(
          builder: (context, filterProvider, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomScrollView(
                slivers: [
                  _getBottomSheetHeader('Pokemon Types'),
                  SliverGrid.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 2,
                    ),
                    itemCount: filterProvider.types.length,
                    itemBuilder: (context, index) {
                      final pokemonType = filterProvider.types[index];

                      return FilterChip(
                        elevation: 1,
                        showCheckmark: false,
                        padding: const EdgeInsets.all(8),
                        selected: filterProvider.selectedTypes.contains(pokemonType),
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
                        onSelected: (_) {
                          Provider.of<FilterProvider>(context, listen: false)
                            .toggleTypeSelection(pokemonType);

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
                        },
                      );
                    }
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  Widget _getBottomSheetHeader(String title) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      pinned: true,

      expandedHeight: 50.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold
          )
        ),
      ),
    );
  }
}