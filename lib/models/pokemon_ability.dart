import 'package:pokedex/utils/helpers/format_text_helper.dart';

class PokemonAbility {
  final String name;
  final String flavorText;
  final String effect;

  PokemonAbility({
    required this.name,
    required this.flavorText,
    required this.effect,
  });

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    final ability = json['ability'];

    return PokemonAbility (
      name: FormatTextHelper.formatName(ability['name']),
      flavorText: FormatTextHelper.formatFlavorText(ability),
      effect: FormatTextHelper.formatFlavorText(
        ability,
        collection: 'effects',
        key: 'effect'
      )
    );
  }

  @override
  String toString() {
    return name;
  }
}