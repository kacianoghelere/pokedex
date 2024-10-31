import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/favorite_pokemons_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class ToggleFavoritePokemonButton extends StatelessWidget {
  final Pokemon pokemon;

  const ToggleFavoritePokemonButton({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonProvider>(
      builder: (context, pokemonProvider, _) {
        return IconButton(
          iconSize: 20,
          padding: EdgeInsets.zero,
          icon: Icon(
            pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
          ),
          onPressed: () {
            Provider.of<FavoritePokemonsProvider>(context, listen: false)
              .toggleFavorite(pokemon);
          },
        );
      },
    );
  }
}