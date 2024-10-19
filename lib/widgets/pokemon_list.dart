import 'package:flutter/cupertino.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    final filterProvider = Provider.of<FilterProvider>(context);

    final pokemons = filterProvider.showFavoritesOnly
        ? pokemonProvider.favorites
        : pokemonProvider.pokemons;

    return ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];

        return PokemonCard(pokemon: pokemon);
      },
    );
  }
}
