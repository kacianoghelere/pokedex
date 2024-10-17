import 'package:pokedex/models/pokemon.dart';

class PokemonEvolutionChain {
  final List<Pokemon> stages;

  PokemonEvolutionChain({required this.stages});

  factory PokemonEvolutionChain.fromJson(Map<String, dynamic> json) {
    List<Pokemon> stages = [];

    for (var speciesInfo in (json['species'] as List)) {
      for (var pokemon in (speciesInfo['pokemons'] as List)) {
        stages.add(Pokemon.fromJson(pokemon));
      }
    }

    return PokemonEvolutionChain(stages: stages);
  }
}