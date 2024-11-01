import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_generation.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/widgets/pokemon_type_badge.dart';
import 'package:provider/provider.dart';

class FilterChips extends StatefulWidget {
  const FilterChips({super.key});

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  bool _isOffstaged = true;

  @override
  Widget build(BuildContext context) => Consumer<FilterProvider>(
    builder: (context, filterProvider, _) {
      if (filterProvider.selectedTypes.isEmpty
        && filterProvider.selectedGenerations.isEmpty
        && filterProvider.searchText.isEmpty
      ) {
        return const SizedBox();
      }

      final searchTextChip = _buildSearchChip(filterProvider.searchText);

      final types = filterProvider.selectedTypes
        .map((pokemonType) => _buildTypeChip(pokemonType))
        .toList();

      final generations = filterProvider.selectedGenerations
        .map((generation) => _buildGenerationChip(generation))
        .toList();

      final List<Widget> chips = <Widget>[
        if (filterProvider.searchText.isNotEmpty) searchTextChip,
        ...generations,
        ...types,
      ];

      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width,
          minWidth: _isOffstaged ? 0 : MediaQuery.sizeOf(context).width
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _toggleExpansion,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).inputDecorationTheme.fillColor
              ),
              child: Padding(
                padding: _isOffstaged
                 ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
                 : const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (_isOffstaged) _buildHeaderTitle(),
                    if (!_isOffstaged) _buildHeaderWithClearAction(),
                    _buildWrappedChips(chips)
                  ],
                ),
              )
            ),
          ),
        ),
      );
    }
  );

  void _toggleExpansion() {
    setState(() {
      _isOffstaged = !_isOffstaged;
    });
  }

  Widget _buildHeaderTitle() {
    return Text(
      'Selected filters',
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  Widget _buildHeaderWithClearAction() => Consumer<FilterProvider>(
    builder: (context, filterProvider, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeaderTitle(),
          InkWell(
            radius: 16,
            onTap: () {
              filterProvider.clearFilters();

              Provider.of<PokemonProvider>(context, listen: false)
                .fetchPokemons(
                  generations: filterProvider.selectedGenerations,
                  pokemonTypes: filterProvider.selectedTypes,
                  searchText: filterProvider.searchText,
                  page: 0
                );
            },
            child: Row(
              children: [
                Icon(
                  Icons.clear,
                  color: Theme.of(context).textTheme.labelSmall?.color,
                  size: 13
                ),
                Text(
                  'Clear',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            )
          ),
        ],
      );
    }
  );

  Widget _buildCustomChip(String label) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall
        ),
      )
    );
  }

  Widget _buildSearchChip(String searchText) {
    return _buildCustomChip("Search: $searchText");
  }

  Widget _buildGenerationChip(PokemonGeneration generation) {
    return _buildCustomChip(generation.name);
  }

  Widget _buildTypeChip(PokemonType pokemonType) {
    return PokemonTypeBadge(type: pokemonType.type);
  }

  Widget _buildWrappedChips(List<Widget> children) {
    return Offstage(
      offstage: _isOffstaged,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 4,
          runSpacing: 8,
          children: children
        ),
      ),
    );
  }
}
