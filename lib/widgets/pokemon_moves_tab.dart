import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/widgets/pokemon_type_icon.dart';

class PokemonMovesTab extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonMovesTab({
    super.key,
    required this.pokemon
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    // TODO: Add move text filter
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      itemCount: pokemon.sortedMoves.length,
      itemBuilder: (context, index) {
        final item = pokemon.sortedMoves[index];

        return ListTile(
          leading: PokemonTypeImage(
            PokemonTypeEnum.parse(item.type.name),
            height: 24,
            width: 24,
          ),
          title: Text(
            item.name,
            style: textStyle.copyWith(fontWeight: FontWeight.bold)
          ),
          subtitle: Text(
            item.flavorText,
            style: textStyle.copyWith(fontStyle: FontStyle.italic)
          ),
          trailing: Text(
            item.level.toString(),
            style: textStyle,
          ),
        );
      }
    );
  }
}
