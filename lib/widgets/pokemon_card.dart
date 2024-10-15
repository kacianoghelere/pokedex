import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/screens/pokemon_detail_screen.dart';
import 'package:pokedex/utils/type_colors.dart';
import 'package:pokedex/widgets/type_badge.dart';
import 'package:provider/provider.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final typeColor = getTypeColor(pokemon.types.first);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailScreen(pokemon: pokemon)
          ),
        );
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Card(
              shadowColor: typeColor,
              color: HSLColor.fromColor(typeColor).withLightness(0.85).toColor(),
              surfaceTintColor: typeColor,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              elevation: 1,
              child: Stack(
                children: [
                  Positioned(
                    top: -75,
                    right: -10,
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        "assets/images/pokeball-background.png",
                        width: 275,
                        height: 275,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "#${pokemon.id}",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    toBeginningOfSentenceCase(pokemon.name),
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: Icon(
                                pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                pokemonProvider.toggleFavorite(pokemon);
                              },
                              padding: EdgeInsets.zero
                            )
                          ],
                        ),
                        Row(
                          children: pokemon.types.map((type) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: TypeBadge(type: type),
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  )
                ]
              ),
            ),
          ),
          Positioned(
            right: 16,
            child: Image.network(
              pokemon.sprite,
              width: 150,
              height: 150
            ),
          ),
        ]
      ),
    );
  }
}
