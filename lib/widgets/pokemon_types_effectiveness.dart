import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/utils/enums/pokemon_type_effectiveness.dart';
import 'package:pokedex/widgets/pokemon_type_badge.dart';
import 'package:pokedex/features/pokemon_details/widgets/section_title.dart';

class PokemonTypesEffectiveness extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonTypesEffectiveness({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Effectiveness'),
        GridView.count(
          childAspectRatio: 3.5,
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          primary: false,
          shrinkWrap: true,
          children: pokemon.effectiveness.map((entry) {
            var effectivenessInfo = _getEffectivenessInfo(entry.effectiveness);

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: PokemonTypeBadge(
                    type: entry.type.name
                  )
                ),
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
              ],
            );
          }).toList()
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