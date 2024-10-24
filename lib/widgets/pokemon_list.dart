import 'package:flutter/cupertino.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemons;
  bool shrinkWrap;

  PokemonList({super.key, required this.pokemons, this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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