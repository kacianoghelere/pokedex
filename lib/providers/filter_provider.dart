import 'package:flutter/foundation.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:pokedex/models/generation.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/utils/services/pokemon_service.dart';

class FilterProvider with ChangeNotifier {
  bool _showFavoritesOnly = false;
  List<Generation> _generations = [];
  List<PokemonType> _types = [];
  List<PokemonType> _selectedTypes = [];
  List<Generation> _selectedGenerations = [];
  final generationsController = MultiSelectController<Generation>();
  final pokemonTypesController = MultiSelectController<PokemonType>();

  List<Generation> get generations => _generations;

  List<PokemonType> get types => _types;

  List<Generation> get selectedGenerations => _selectedGenerations;

  List<PokemonType> get selectedTypes => _selectedTypes;

  bool get showFavoritesOnly => _showFavoritesOnly;

  Future<void> fetchFilterData() async {
    final result = await PokemonService.fetchFilters();

    if (result.hasException) {
      print("ERROR ${result.exception}");

      return;
    }

    _types = (result.data?['pokemon_v2_type'] as List)
      .map((data) => PokemonType.fromJson(data))
      .toList();

    if (kDebugMode) {
      debugPrint(_types.map((type) => type.type).toList().toString());
    }

    _generations = (result.data?['pokemon_v2_generation'] as List)
      .map((data) => Generation.fromJson(data))
      .toList();

    notifyListeners();
  }

  void setGenerationIds(List<Generation> generations) {
    _selectedGenerations = generations;

    notifyListeners();
  }

  void setTypes(List<PokemonType> types) {
    _selectedTypes = types;

    notifyListeners();
  }

  void toggleFavoritesOnly() {
    _showFavoritesOnly = !_showFavoritesOnly;

    notifyListeners();
  }

  void clearFilters() {
    _selectedGenerations.clear();

    _selectedTypes.clear();

    _showFavoritesOnly = false;

    notifyListeners();
  }
}
