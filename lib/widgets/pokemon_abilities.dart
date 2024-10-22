import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/widgets/section_title.dart';

class PokemonAbilities extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonAbilities({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Abilities'),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pokemon.abilities.length,
          itemBuilder: (context, index) {
            final ability = pokemon.abilities[index];

            return ListTile(
              title: Text(
                toBeginningOfSentenceCase(ability.name),
                style: const TextStyle(fontWeight: FontWeight.bold)
              ),
              subtitle: Text(ability.flavorText)
            );
          }
        )
      ],
    );
  }
}
