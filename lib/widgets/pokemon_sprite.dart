import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonSprite extends StatelessWidget {
  static const double _spriteScaleFactor = 0.8;

  final Pokemon pokemon;
  final double size;
  final double spriteSize;

  const PokemonSprite({
    super.key,
    required this.pokemon,
    required this.size
  }): spriteSize = (size * _spriteScaleFactor);

  double get spritePosition => (size - (spriteSize)) / 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.35,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(pokemon.typeColor, BlendMode.srcIn),
            child: Image.asset(
              "assets/images/pokeball-background-minimal.png",
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: spritePosition + 4,
          left: spritePosition + 4,
          child: Opacity(
            opacity: 0.4,
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              child: CachedNetworkImage(
                imageUrl: pokemon.sprite,
                height: spriteSize,
                width: spriteSize,
                placeholder: (context, url) {
                  return const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: spritePosition,
          left: spritePosition,
          child: CachedNetworkImage(
            imageUrl: pokemon.sprite,
            height: spriteSize,
            width: spriteSize,
            placeholder: (context, url) {
              return const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ]
    );
  }
}