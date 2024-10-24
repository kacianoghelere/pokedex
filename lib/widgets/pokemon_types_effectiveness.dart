import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/utils/enums/pokemon_type_effectiveness.dart';
import 'package:pokedex/widgets/pokemon_type_badge.dart';
import 'package:pokedex/widgets/section_title.dart';

class PokemonTypesEffectiveness extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonTypesEffectiveness({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Effectiveness'),
        GridView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3,
            crossAxisCount: 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemCount: pokemon.effectiveness.length,
          itemBuilder: (context, index) {
            final entry = pokemon.effectiveness[index];

            var effectivenessInfo = _getEffectivenessInfo(entry.effectiveness);

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: effectivenessInfo.iconData != null
                    ? Icon(
                      effectivenessInfo.iconData,
                      color: effectivenessInfo.color
                    )
                    : null
                ),
                PokemonTypeBadge(type: entry.type.name),
                const SizedBox(height: 8),
              ],
            );
          },
        ),
      ],
    );
  }

  static ({IconData? iconData, Color color}) _getEffectivenessInfo(
    PokemonTypeEffectivenessEnum effectiveness
  ) {
    return switch(effectiveness) {
      PokemonTypeEffectivenessEnum.vulnerable => (
        iconData: Icons.keyboard_double_arrow_down_sharp,
        color: Colors.red
      ),
      PokemonTypeEffectivenessEnum.resistant => (
        iconData: Icons.keyboard_double_arrow_up_sharp,
        color: Colors.green
      ),
      _ => (
        iconData: null,
        color: Colors.grey
      )
    };
  }
}