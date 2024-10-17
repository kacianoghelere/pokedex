import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon.dart';

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
            Colors.cyan.shade200,
            Colors.purple.shade200,
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
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 96),
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
            width: 175,
            height: 175,
          ),
          const SizedBox(height: 12),
          Text(
            toBeginningOfSentenceCase(pokemon.name),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}