import 'package:flutter/foundation.dart';
import 'package:pokedex/models/pokemon_generation.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/utils/extensions/list_extension.dart';
import 'package:pokedex/utils/services/pokemon_service.dart';

class FilterProvider with ChangeNotifier {
  bool _showFavoritesOnly = false;
  String _searchText = '';
  List<PokemonGeneration> _generations = [];
  List<PokemonType> _types = [];
  List<PokemonType> _selectedTypes = [];
  List<PokemonGeneration> _selectedGenerations = [];

  List<PokemonGeneration> get selectedGenerations => _selectedGenerations;

  List<PokemonType> get selectedTypes => _selectedTypes;

  bool get showFavoritesOnly => _showFavoritesOnly;

  Future<void> fetchFilterData() async {
    _selectedGenerations.clear();

    _selectedTypes.clear();

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

  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value;

    notifyListeners();
  }

  List<PokemonGeneration> get generations => _generations;

  set generations(List<PokemonGeneration> generations) {
    _selectedGenerations = generations;

    notifyListeners();
  }

  List<PokemonType> get types => _types;

  set types(List<PokemonType> types) {
    _selectedTypes = types;

    notifyListeners();
  }

  void toggleGenerationSelection(PokemonGeneration generation) {
    _selectedGenerations.toggleElement(generation);

    notifyListeners();
  }

  void toggleTypeSelection(PokemonType type) {
    _selectedTypes.toggleElement(type);

    notifyListeners();
  }

  void toggleFavoritesOnly() {
    _showFavoritesOnly = !_showFavoritesOnly;

    notifyListeners();
  }

  void clearGenerationFilter() {
    _selectedGenerations.clear();

    notifyListeners();
  }

  void clearTypeFilter() {
    _selectedTypes.clear();

    notifyListeners();
  }

  void clearFilters() {
    _searchText = '';

    _selectedGenerations.clear();

    _selectedTypes.clear();

    _showFavoritesOnly = false;

    notifyListeners();
  }
}
