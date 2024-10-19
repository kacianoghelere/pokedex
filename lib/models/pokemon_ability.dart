import 'package:pokedex/utils/helpers/flavor_text_helper.dart';

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
      name: ability['name'],
      flavorText: FlavorTextHelper.extract(ability),
      effect: FlavorTextHelper.extract(
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