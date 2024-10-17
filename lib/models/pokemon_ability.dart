import 'package:pokedex/utils/format_helper.dart';

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
    return PokemonAbility (
      name: json['ability']['name'],
      flavorText: formatFlavorText(json['ability']['flavor_texts'][0]['flavor_text']),
      effect: formatFlavorText(json['ability']['effects'][0]['effect'])
    );
  }
}