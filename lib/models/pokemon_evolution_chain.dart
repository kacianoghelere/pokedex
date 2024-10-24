import 'package:pokedex/models/pokemon.dart';

class PokemonEvolutionChain {
  final List<Pokemon> stages;

  PokemonEvolutionChain({required this.stages});

  factory PokemonEvolutionChain.fromJson(Map<String, dynamic> json) {
    final stages = (json['species'] as List? ?? [])
      .expand((speciesInfo) => speciesInfo['pokemons'] as List? ?? [])
      .map((pokemon) => Pokemon.fromJson(pokemon))
      .toList();

    return PokemonEvolutionChain(stages: stages);
  }
}