import 'package:intl/intl.dart';
import 'package:pokedex/models/filter_data.dart';

String _parseGenerationName(String name) {
  var splittedName = name.split('-');

  return '${toBeginningOfSentenceCase(splittedName.first)} ${splittedName.last.toUpperCase()}';
}

class PokemonGeneration extends FilterData {
  PokemonGeneration({
    required super.id,
    required String name
  }):
    super(name: _parseGenerationName(name));

  factory PokemonGeneration.fromJson(Map<String, dynamic> json) {
    return PokemonGeneration(
      id: json['id'],
      name: json['name']
    );
  }

  @override
  String toString() {
    return 'Generation(id: $id, name: $name)';
  }
}