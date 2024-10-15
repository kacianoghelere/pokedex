import 'package:intl/intl.dart';
import 'package:pokedex/models/filter_data.dart';

class PokemonType extends FilterData {
  final String type;

  PokemonType({
    required super.id,
    required String name
  }):
    type = name,
    super(name: toBeginningOfSentenceCase(name));

  PokemonType.fromJson(Map<String, dynamic> json):
    this(
      id: json['id'],
      name: json['name']
    );

  @override
  String toString() {
    return 'PokemonType(id: $id, name: $name, type: $type)';
  }
}