import 'package:flutter/material.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/widgets/error_indicator.dart';
import 'package:pokedex/features/home/widgets/pokemon_list.dart';
import 'package:pokedex/features/home/widgets/pokemon_filters_button.dart';
import 'package:pokedex/features/home/widgets/toggle_theme_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    _fetchPokemons();
  }

  void _fetchPokemons({int page = 0}) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);

    final pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);

    pokemonProvider.fetchPokemons(
      generations: filterProvider.selectedGenerations,
      pokemonTypes: filterProvider.selectedTypes,
      searchText: filterProvider.searchText,
      page: page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle
          ?? Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontFamily: 'PokemonSolid',
            shadows: [
              const Shadow(
                blurRadius: 1,
                color: Colors.black87,
                offset: Offset(1.0, 1.0),
              )
            ]
          ),
        actions: const [
          ThemeToggleButton(),
        ],
        actionsIconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: SafeArea(
        child: Consumer2<FilterProvider, PokemonProvider>(
          builder: (context, filterProvider, pokemonProvider, _) {
            if (pokemonProvider.hasException) {
              return const ErrorIndicator();
            }

            final pokemons = filterProvider.showFavoritesOnly
              ? pokemonProvider.favorites
              : pokemonProvider.pokemons;

            return PokemonList(
              pokemons: pokemons,
              onEdgeReached: () {
                _fetchPokemons(page: pokemonProvider.currentPage + 1);
              },
              onSearchTextChanged: (String searchText) {
                filterProvider.searchText = searchText;

                _fetchPokemons(page: 0);
              },
            );
          }
        )
      ),
      floatingActionButton: const PokemonFiltersButton()
    );
  }
}