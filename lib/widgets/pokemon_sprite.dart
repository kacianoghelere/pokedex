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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.35,
          child: Image.asset(
            "assets/images/pokeball-background-minimal.png",
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: (size - (spriteSize)) / 2,
          left: (size - (spriteSize)) / 2,
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