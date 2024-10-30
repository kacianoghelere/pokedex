import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/extensions/color_extension.dart';

class PokemonSprite extends StatelessWidget {
  static const double _spriteScaleFactor = 0.8;

  final Pokemon pokemon;
  final double size;
  final double spriteSize;

  const PokemonSprite({
    super.key,
    required this.pokemon,
    required this.size,
  }): spriteSize = (size * _spriteScaleFactor);

  double get spritePosition => (size - (spriteSize)) / 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RepaintBoundary(
          child: Opacity(
            opacity: 0.5,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                pokemon.typeColor.getColorByThemeMode(context),
                BlendMode.srcIn
              ),
              child: Image.asset(
                "assets/images/pokeball-background.png",
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
          ).animate(
            delay: const Duration(milliseconds: 300),
            // FIXME: Fix the animations cost
            // onPlay: (controller) => controller.repeat(reverse: true),
            effects: [
              const RotateEffect(
                curve: Easing.linear,
                delay: Duration(milliseconds: 300),
                duration: Duration(seconds: 20)
              ),
            ]
          )
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