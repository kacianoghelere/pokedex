import 'package:flutter/foundation.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:pokedex/models/pokemon_generation.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/utils/services/pokemon_service.dart';

class FilterProvider with ChangeNotifier {
  bool _showFavoritesOnly = false;
  List<PokemonGeneration> _generations = [];
  List<PokemonType> _types = [];
  List<PokemonType> _selectedTypes = [];
  List<PokemonGeneration> _selectedGenerations = [];
  final generationsController = MultiSelectController<PokemonGeneration>();
  final pokemonTypesController = MultiSelectController<PokemonType>();

  List<PokemonGeneration> get generations => _generations;

  List<PokemonType> get types => _types;

  List<PokemonGeneration> get selectedGenerations => _selectedGenerations;

  List<PokemonType> get selectedTypes => _selectedTypes;

  bool get showFavoritesOnly => _showFavoritesOnly;

  Future<void> fetchFilterData() async {
    final (result, exception) = await PokemonService.fetchFilters();

    if (exception != null) {
      debugPrint("ERROR fetchFilterData ${exception.toString()}");

      return;
    }

    if (result != null) {
      var (generations, types) = result;

      _types = types;

      _generations = generations;
    }

    notifyListeners();
  }

  void setGenerationIds(List<PokemonGeneration> generations) {
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
