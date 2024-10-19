import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/utils/helpers/flavor_text_helper.dart';

class PokemonMove {
  final String name;
  final String flavorText;
  final int? accuracy;
  final int level;
  final PokemonTypeEnum type;

  PokemonMove({
    required this.name,
    required this.flavorText,
    required this.accuracy,
    required this.level,
    required this.type
  });

  factory PokemonMove.fromJson(Map<String, dynamic> json){
    final move = json['move'];

    return PokemonMove(
      name: move['name'],
      flavorText: FlavorTextHelper.extract(move),
      accuracy: move['accuracy'],
      level: json['level'],
      type: PokemonTypeEnum.parse(move['type']['name'])
    );
  }
}