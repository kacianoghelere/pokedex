import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/screens/pokemon_details_screen.dart';
import 'package:pokedex/utils/pokemon_type_colors.dart';
import 'package:pokedex/widgets/pokemon_sprite.dart';
import 'package:pokedex/widgets/pokemon_type_badge.dart';
import 'package:provider/provider.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final typeColor = getTypeColor(pokemon.types.first.name);

    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkMode;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailsScreen(pokemon: pokemon)
          ),
        );
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Card(
              elevation: 0,
              color: isDarkTheme
                ? HSLColor.fromColor(typeColor).withLightness(0.15).toColor()
                : HSLColor.fromColor(typeColor).withLightness(0.85).toColor(),
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shadowColor: typeColor,
              surfaceTintColor: typeColor,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Opacity(
                      opacity: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: isDarkTheme
                            ? HSLColor.fromColor(typeColor).withLightness(0.25).toColor()
                            : HSLColor.fromColor(typeColor).withLightness(0.65).toColor(),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(16),
                            topLeft: Radius.circular(16)
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 4.0
                          ),
                          child: Text(
                            "#${pokemon.id}",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              shadows: isDarkTheme ? [
                                const Shadow(
                                  blurRadius: 1,
                                  color: Colors.black87,
                                  offset: Offset(1.0, 1.0),
                                )
                              ] : null
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 24, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    toBeginningOfSentenceCase(pokemon.name),
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      shadows: isDarkTheme ? [
                                        const Shadow(
                                          blurRadius: 1,
                                          color: Colors.black87,
                                          offset: Offset(1.0, 1.0),
                                        )
                                      ] : null
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: pokemon.types.map((pokemonType) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: PokemonTypeBadge(type: pokemonType.type),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        PokemonSprite(
                          size: 100,
                          pokemon: pokemon,
                        )
                      ],
                    )
                  )
                ]
              ),
            ),
          )
        ]
      ),
    );
  }
}
