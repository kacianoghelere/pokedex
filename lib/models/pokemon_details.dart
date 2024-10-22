import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_ability.dart';
import 'package:pokedex/models/pokemon_evolution_chain.dart';
import 'package:pokedex/models/pokemon_move.dart';
import 'package:pokedex/models/pokemon_stat.dart';
import 'package:pokedex/utils/helpers/format_text_helper.dart';

class PokemonDetails extends Pokemon {
  final String description;
  final int baseExperience;
  final int height;
  final int weight;
  final List<PokemonMove> moves;
  final List<PokemonAbility> abilities;
  final List<PokemonStat> stats;
  final PokemonEvolutionChain evolutionChain;

  PokemonDetails({
    required super.id,
    required super.name,
    required super.types,
    required super.sprite,
    required super.isFavorite,
    required this.baseExperience,
    required this.description,
    required this.height,
    required this.weight,
    required this.moves,
    required this.abilities,
    required this.stats,
    required this.evolutionChain,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      id: json['id'],
      name: json['name'],
      types: (json['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList(),
      sprite: json['sprites'][0]['front_default'] ?? '',
      isFavorite: false,
      description: FormatTextHelper.formatFlavorText(json['species']),
      baseExperience: json['base_experience'],
      height: json['height'],
      weight: json['weight'],
      moves: (json['moves']['nodes'] as List)
        .map((data) => PokemonMove.fromJson(data))
        .toList(),
      abilities: (json['abilities'] as List)
        .map((data) => PokemonAbility.fromJson(data))
        .toList(),
      stats: (json['stats'] as List)
        .map((data) => PokemonStat.fromJson(data))
        .toList(),
      evolutionChain: PokemonEvolutionChain.fromJson(json['species']['evolution_chain'])
    );
  }
}