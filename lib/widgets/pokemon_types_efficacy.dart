import 'package:flutter/material.dart';
import 'package:pokedex/widgets/pokemon_type_badge.dart';

class PokemonTypesEfficacy extends StatelessWidget {
  final List<Map<String, dynamic>> effectivenessData;

  const PokemonTypesEfficacy({super.key, required this.effectivenessData});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: effectivenessData.length,
      itemBuilder: (context, index) {
        final entry = effectivenessData[index];
        final typeName = entry['pokemon_v2_type']['name'];
        final damageFactor = entry['damage_factor'];

        var (IconData? iconData, Color backgroundColor) = switch(damageFactor) {
          < 100 => (Icons.keyboard_double_arrow_up_sharp, Colors.red),
          > 100 => (Icons.keyboard_double_arrow_down_sharp, Colors.green),
          _ => (null, Colors.grey)
        };

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PokemonTypeBadge(type: typeName),
              const SizedBox(height: 8),
              if (iconData != null) Icon(
                iconData,
                color: backgroundColor,
              ),
            ],
          ),
        );
      },
    );
  }
}