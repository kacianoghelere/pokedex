import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/screens/pokemon_details_screen.dart';
import 'package:pokedex/utils/helpers/pokemon_types_helper.dart';
import 'package:pokedex/utils/pokemon_type_colors.dart';
import 'package:pokedex/widgets/pokemon_sprite.dart';
import 'package:pokedex/widgets/pokemon_types.dart';
import 'package:provider/provider.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final typeColor = getTypeColor(pokemon.types.first.name);

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
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  opacity: 0.15,
                  image: AssetImage(PokemonTypesHelper.getTypeBackground(pokemon.mainType.type))
                ),
                color: typeColor,
                gradient: _getBackgroundGradient(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getPokemonIdBadge(context),
                        _getPokemonName(context),
                        PokemonTypes(pokemon: pokemon)
                      ],
                    ),
                    PokemonSprite(
                      size: 128,
                      pokemon: pokemon,
                    )
                  ],
                )
              ),
            ),
          )
        ]
      ),
    );
  }

  Widget _getPokemonName(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        toBeginningOfSentenceCase(pokemon.name),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          shadows: isDarkMode ? [
            const Shadow(
              blurRadius: 1,
              color: Colors.black87,
              offset: Offset(1.0, 1.0),
            )
          ] : null
        ),
      ),
    );
  }

  Widget _getPokemonIdBadge(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    var hslColor = HSLColor.fromColor(pokemon.typeColor);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDarkMode
            ? hslColor.withLightness(0.2).toColor()
            : hslColor.withLightness(0.45).toColor(),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0
          ),
          child: Text(
            "#${pokemon.id}",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.bold,
              shadows: isDarkMode ? [
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
    );
  }

  LinearGradient _getBackgroundGradient(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return LinearGradient(
      begin: AlignmentDirectional.topCenter,
      end: AlignmentDirectional.bottomEnd,
      colors: _getBackgroundGradientColors(isDarkMode)
    );
  }

  List<Color> _getBackgroundGradientColors(bool isDarkMode) {
    var hslColor = HSLColor.fromColor(pokemon.typeColor);

    if (isDarkMode) {
      return [
        hslColor.withLightness(0.1).toColor(),
        hslColor.withLightness(0.2).toColor(),
        hslColor.withLightness(0.3).toColor(),
      ];
    }

    return [
      hslColor.withLightness(0.7).toColor(),
      hslColor.withLightness(0.6).toColor(),
      hslColor.withLightness(0.5).toColor(),
    ];
  }
}