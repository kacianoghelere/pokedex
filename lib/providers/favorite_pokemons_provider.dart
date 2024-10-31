import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pokedex/models/pokemon.dart';

class FavoritePokemonsProvider with ChangeNotifier {
  final Box<Pokemon> _favoritesBox = Hive.box<Pokemon>('favorite_pokemons');

  List<Pokemon> get favorites => _favoritesBox.values.toList();

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