import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon_details.dart';

class PokemonInfoTab extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonInfoTab({
    super.key,
    required this.pokemon
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pokemon.description,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontStyle: FontStyle.italic
              )
            ),
            const SizedBox(height: 16),
            const _SectionTitle(title: 'Basic Info'),
            _DetailRow(label: 'Height', value: '${pokemon.height / 10}m'),
            _DetailRow(label: 'Weight', value: '${pokemon.weight / 10}kg'),
            _DetailRow(label: 'Base Experience', value: '${pokemon.baseExperience}'),
            const _SectionTitle(title: 'Stats'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pokemon.stats.length,
              itemBuilder: (context, index) {
                final stat = pokemon.stats[index];

                return _DetailRow(
                  label: stat.name,
                  value: stat.value.toString()
                );
              }
            ),
            const _SectionTitle(title: 'Abilities'),
            ListView.builder(
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
                  subtitle: Text(
                    ability.flavorText
                  ),
                );
              }
            )
          ]
        ),
      )
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold
        )
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '$label: ',
            style: textStyle!.copyWith(fontWeight: FontWeight.bold)
          ),
          Expanded(
            child: Text(
              value,
              style: textStyle
            )
          ),
        ],
      ),
    );
  }
}