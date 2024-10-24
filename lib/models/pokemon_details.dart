import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_ability.dart';
import 'package:pokedex/models/pokemon_evolution_chain.dart';
import 'package:pokedex/models/pokemon_move.dart';
import 'package:pokedex/models/pokemon_stat.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/utils/enums/pokemon_type_effectiveness.dart';
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
  final Map<PokemonTypeEnum, PokemonTypeEffectivenessEnum> effectiveness;

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
    required this.effectiveness,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
      .map((data) => PokemonType.fromJson(data))
      .toList();

    final moves = (json['moves']['nodes'] as List)
      .map((data) => PokemonMove.fromJson(data))
      .toList();

    final abilities = (json['abilities'] as List)
      .map((data) => PokemonAbility.fromJson(data))
      .toList();

    final stats = (json['stats'] as List)
      .map((data) => PokemonStat.fromJson(data))
      .toList();

    return PokemonDetails(
      id: json['id'],
      name: json['name'],
      types: types,
      sprite: json['sprites'][0]['front_default'] ?? '',
      isFavorite: false,
      description: FormatTextHelper.formatFlavorText(json['species']),
      baseExperience: json['base_experience'],
      height: json['height'],
      weight: json['weight'],
      moves: moves,
      abilities: abilities,
      stats: stats,
      evolutionChain: PokemonEvolutionChain.fromJson(json['species']['evolution_chain']),
      effectiveness: _calculateTotalEffectiveness(types),
    );
  }

  List<PokemonMove> get sortedMoves {
    return moves..sort((a, b) => a.level.compareTo(b.level));
  }

  static Map<PokemonTypeEnum, PokemonTypeEffectivenessEnum> _calculateTotalEffectiveness(
    List<PokemonType> types
  ) {
    final Map<PokemonTypeEnum, int> effectivenessScores = {};

    for (var pokemonType in types) {
      for (var entry in pokemonType.effectiveness.entries) {
        final type = entry.key;

        final effectivenessValue = entry.value.score;

        effectivenessScores[type] = (effectivenessScores[type] ?? 0) + effectivenessValue;
      }
    }

    return effectivenessScores.map((type, score) => MapEntry(
      type,
      PokemonTypeEffectivenessEnum.parse(score),
    ));
  }

  @override
  String toString() {
    return 'PokemonDetails(id: $id, name: $name)';
  }
}