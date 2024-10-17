import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/pokemon_type_colors.dart';

class PokemonCarouselCard extends StatelessWidget {
  final Pokemon pokemon;
  final bool isSelected;

  const PokemonCarouselCard({
    super.key,
    required this.pokemon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            getTypeColor(pokemon.types.first),
            getTypeColor(pokemon.types.last),
          ],
        ),
        shadows: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: -2,
            // you can animate the radius to make the feeling of cards
            // 'coming closer to you' stronger
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) {
              return const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              );
            },
            imageUrl: pokemon.sprite,
            width: 250,
            height: 250,
          ),
          const SizedBox(height: 12),
          Text(
            toBeginningOfSentenceCase(pokemon.name),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              shadows: [
                const Shadow(
                  blurRadius: 1,
                  color: Colors.black87,
                  offset: Offset(1.0, 1.0),
                )
              ],
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}