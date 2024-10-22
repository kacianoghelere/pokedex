import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/widgets/section_title.dart';

class PokemonBasicInfo extends StatefulWidget {
  final PokemonDetails pokemon;

  const PokemonBasicInfo({super.key, required this.pokemon});

  @override
  State<PokemonBasicInfo> createState() => _PokemonBasicInfoState();
}

class _PokemonBasicInfoState extends State<PokemonBasicInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Basic Info'),
        _getInfoTile('Height', '${widget.pokemon.height / 10}m'),
        _getInfoTile('Weight', '${widget.pokemon.weight / 10}kg'),
        _getInfoTile('Base Experience', widget.pokemon.baseExperience.toString()),
      ],
    );
  }

  Widget _getInfoTile(String label, String value) {
    return ListTile(
      title: Text(
        toBeginningOfSentenceCase(label),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold
        )
      ),
      trailing: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium
      ),
    );
  }
}
