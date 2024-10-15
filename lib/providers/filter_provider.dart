import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  int _selectedGeneration = 1;
  List<String> _selectedTypes = [];
  bool _showFavoritesOnly = false;

  int get selectedGeneration => _selectedGeneration;
  List<String> get selectedTypes => _selectedTypes;
  bool get showFavoritesOnly => _showFavoritesOnly;

  /// Atualiza a geração selecionada.
  void setGeneration(int generation) {
    _selectedGeneration = generation;
    notifyListeners();
  }

  /// Adiciona ou remove um tipo da lista de tipos selecionados.
  void toggleType(String type) {
    if (_selectedTypes.contains(type)) {
      _selectedTypes.remove(type);
    } else {
      _selectedTypes.add(type);
    }
    notifyListeners();
  }

  /// Alterna o filtro de favoritos.
  void toggleFavoritesOnly() {
    _showFavoritesOnly = !_showFavoritesOnly;
    notifyListeners();
  }

  /// Limpa todos os filtros.
  void clearFilters() {
    _selectedGeneration = 1;
    _selectedTypes.clear();
    _showFavoritesOnly = false;
    notifyListeners();
  }
}
