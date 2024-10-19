import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pokedex/models/generation.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/utils/services/pokemon_service.dart';

class PokemonProvider with ChangeNotifier {
  final Box<Pokemon> _favoritesBox = Hive.box<Pokemon>('favorite_pokemons');
  List<Pokemon> _pokemons = [];

  List<Pokemon> get pokemons => _pokemons;

  List<Pokemon> get favorites => _favoritesBox.values.toList();

  Future<void> fetchPokemons({
    required List<Generation> generations,
    required List<PokemonType> pokemonTypes
  }) async {
    final Map<String, dynamic> where = {};

    if (generations.isNotEmpty) {
      var generationIds = generations.map((item) => item.id).toList();

      where['pokemon_v2_pokemonspecy'] = {
        'generation_id': {'_in': generationIds},
      };
    }

    if (pokemonTypes.isNotEmpty) {
      var types = pokemonTypes.map((item) => item.type).toList();

      where['pokemon_v2_pokemontypes'] = {
        'pokemon_v2_type': {'name': {'_in': types}}
      };
    }

    if (kDebugMode) {
      debugPrint("fetchPokemons params ${where.toString()}");
    }

    final result = await PokemonService.fetchList(where);

    if (result.hasException) {
      if (kDebugMode) {
        debugPrint("fetchPokemons ${result.exception}");
      }

      return;
    }

    _pokemons = (result.data?['pokemon'] as List)
      .map((data) => Pokemon.fromJson(data))
      .toList();

    notifyListeners();
  }

  void toggleFavorite(Pokemon pokemon) {
    pokemon.isFavorite = !pokemon.isFavorite;

    if (pokemon.isFavorite) {
      _favoritesBox.put(pokemon.id, pokemon);
    } else {
      _favoritesBox.delete(pokemon.id);
    }

    notifyListeners();
  }
}
