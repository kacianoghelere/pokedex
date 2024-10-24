import 'package:intl/intl.dart';
import 'package:pokedex/models/filter_data.dart';
import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/utils/enums/pokemon_type_effectiveness.dart';

class PokemonType extends FilterData {
  final String type;
  final Map<PokemonTypeEnum, PokemonTypeEffectivenessEnum> effectiveness;

  PokemonType({
    required super.id,
    required String name,
    Map<PokemonTypeEnum, PokemonTypeEffectivenessEnum>? effectiveness,
  }): type = name,
    effectiveness = effectiveness ?? {},
    super(name: toBeginningOfSentenceCase(name));

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    var type = json['type'];

    return PokemonType(
      id: type['id'] as int,
      name: type['name'] as String,
      effectiveness: _parseEffectiveness(type?['effectiveness']),
    );
  }

  factory PokemonType.asFilter(Map<String, dynamic> json) {
    return PokemonType(
      id: json['id'] as int,
      name: json['name'] as String,
      effectiveness: null
    );
  }

  static Map<PokemonTypeEnum, PokemonTypeEffectivenessEnum> _parseEffectiveness(List? data) {
    if (data == null) return {};

    return {
      for (var item in data)
        PokemonTypeEnum.parse(item['target_type']['name'] as String):
            _mapDamageFactor(item['damage_factor'] as int)
    };
  }

  static PokemonTypeEffectivenessEnum _mapDamageFactor(int damageFactor) {
    return switch (damageFactor) {
      < 100 => PokemonTypeEffectivenessEnum.vulnerable,
      > 100 => PokemonTypeEffectivenessEnum.resistant,
      _ => PokemonTypeEffectivenessEnum.neutral,
    };
  }

  @override
  String toString() {
    return 'PokemonType(id: $id, name: $name, type: $type.name)';
  }
}