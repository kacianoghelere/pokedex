import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pokedex/models/pokemon_generation.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/utils/services/pokemon_service.dart';

class PokemonProvider with ChangeNotifier {
  final List<Pokemon> _pokemons = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasException = false;
  final Box<Pokemon> _favoritesBox = Hive.box<Pokemon>('favorite_pokemons');

  List<Pokemon> get favorites => _favoritesBox.values.toList();

  bool get hasException => _hasException;

  bool get isLoading => _isLoading;

  int get currentPage => _currentPage;

  List<Pokemon> get pokemons => _pokemons;

  Future<void> fetchPokemons({
    required List<PokemonGeneration> generations,
    required List<PokemonType> pokemonTypes,
    String? searchText,
    int? page,
  }) async {
    if (page != null) {
      _currentPage = page;
    }

    if (page == 0) {
      _pokemons.clear();

      // notifyListeners();
    }

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

    if (searchText != null && searchText.isNotEmpty) {
      where['name'] = {
        '_regex': searchText.toLowerCase()
      };
    }

    const int limitPerPage = 15;

    _isLoading = true;

    // notifyListeners();

    final (result, exception) = await PokemonService.fetchList(
      limit: limitPerPage,
      offset: limitPerPage * _currentPage,
      where: where,
    );

    _isLoading = false;

    _hasException = exception != null;

    _pokemons.addAll(result ?? []);

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
