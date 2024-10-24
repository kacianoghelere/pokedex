import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/utils/enums/pokemon_type_effectiveness.dart';

class PokemonTypeEffectiveness {
  final PokemonTypeEnum type;
  final PokemonTypeEffectivenessEnum effectiveness;

  PokemonTypeEffectiveness({
    required this.type,
    required this.effectiveness
  });
}