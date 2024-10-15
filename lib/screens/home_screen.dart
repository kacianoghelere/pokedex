import 'package:flutter/material.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/utils/type_icons.dart';
import 'package:pokedex/widgets/generation_filter.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    _fetchPokemons();
  }

  void _fetchPokemons() {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);

    final pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);

    pokemonProvider.fetchPokemons(
      filterProvider.selectedGeneration,
      filterProvider.selectedTypes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    final filterProvider = Provider.of<FilterProvider>(context);

    final themeProvider = Provider.of<ThemeProvider>(context);

    final pokemons = filterProvider.showFavoritesOnly
        ? pokemonProvider.favorites
        : pokemonProvider.pokemons;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle
          ?? Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontFamily: 'PokemonSolid'
          ),
        actions: [
          IconButton(
            icon: Icon(
              color: Theme.of(context).iconTheme.color,
              filterProvider.showFavoritesOnly
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              filterProvider.toggleFavoritesOnly();
            },
          ),
          IconButton(
            color: Theme.of(context).iconTheme.color,
            icon: const Icon(Icons.filter_list_alt),
            onPressed: () {
              filterProvider.toggleFavoritesOnly();
            },
          ),
          IconButton(
            color: Theme.of(context).iconTheme.color,
            key: const Key('TOGGLE_THEME'),
            icon: Icon(
              themeProvider.mode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleMode();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildFilters(filterProvider),
            Expanded(
              child: ListView.builder(
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemons[index];
                  return PokemonCard(pokemon: pokemon);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(FilterProvider filterProvider) {
    return Column(
      children: [
        _buildGenerationFilter(filterProvider),
        _buildTypeFilter(filterProvider),
      ],
    );
  }

  Widget _buildGenerationFilter(FilterProvider filterProvider) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: GenerationFilter()
    );
  }

  Widget _buildTypeFilter(FilterProvider filterProvider) {
    const allTypes = [
      'grass', 'fire', 'water', 'electric', 'rock', 'ground', 'flying',
      'psychic', 'ice', 'dragon', 'dark', 'fairy'
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Tipos', style: Theme.of(context).textTheme.titleLarge),
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: allTypes.map((type) {
              return FilterChip(
                showCheckmark: false,
                label: Text(
                  getTypeIcon(type),
                  style: const TextStyle(
                    fontFamily: 'PokeGoTypes',
                    fontSize: 24
                  ),
                ),
                selected: filterProvider.selectedTypes.contains(type),
                onSelected: (isSelected) {
                  filterProvider.toggleType(type);
                  _fetchPokemons();
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
