import 'package:pokedex/utils/helpers/format_text_helper.dart';

class PokemonStat {
  final String name;
  final int value;

  PokemonStat({
    required this.name,
    required this.value,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      name: FormatTextHelper.formatName(json['stat']['name']),
      value: json['base_stat']
    );
  }
}