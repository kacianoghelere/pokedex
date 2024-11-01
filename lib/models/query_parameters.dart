import 'package:pokedex/models/pokemon_generation.dart';
import 'package:pokedex/models/pokemon_type.dart';

class QueryParameters {
  String searchText;
  List<PokemonGeneration> generations;
  List<PokemonType> types;

  QueryParameters({
    required this.searchText,
    required this.generations,
    required this.types
  });
}