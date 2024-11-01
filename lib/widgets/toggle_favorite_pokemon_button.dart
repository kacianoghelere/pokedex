import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class ToggleFavoritePokemonButton extends StatelessWidget {
  final Pokemon pokemon;

  const ToggleFavoritePokemonButton({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) => Consumer<PokemonProvider>(
    builder: (context, pokemonProvider, _) {
      return IconButton(
        iconSize: 20,
        padding: EdgeInsets.zero,
        icon: Icon(
          pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
        onPressed: () {
          pokemonProvider.toggleFavorite(pokemon);
        },
      );
    },
  );
}