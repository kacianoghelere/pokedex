import 'package:flutter/cupertino.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/widgets/nothing_found_indicator.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemons;
  final bool shrinkWrap;

  const PokemonList({
    super.key,
    required this.pokemons,
    this.shrinkWrap = false
  });

  @override
  Widget build(BuildContext context) {
    if (pokemons.isEmpty) {
      return const NothingFoundIndicator();
    }

    return ListView.builder(
      addRepaintBoundaries: true,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      shrinkWrap: shrinkWrap,
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];

        return PokemonCard(pokemon: pokemon);
      }
    );
  }
}