import 'package:flutter/material.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/widgets/filters.dart';
import 'package:pokedex/widgets/pokemon_list.dart';
import 'package:pokedex/widgets/show_favorites_button.dart';
import 'package:pokedex/widgets/toggle_theme_button.dart';
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
      generations: filterProvider.selectedGenerations,
      pokemonTypes: filterProvider.selectedTypes,
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
          ShowFavoritesButton(),
          ThemeToggleButton(),
        ],
      ),
      body: const SafeArea(
        child: PokemonList()
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const Filters();
            },
          );
        },
        elevation: 9,
        child: Icon(
          Icons.filter_list_sharp,
          color: Theme.of(context).iconTheme.color
        ),
      ),
    );
  }
}