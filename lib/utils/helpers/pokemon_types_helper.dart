import 'package:flutter/material.dart';
import 'package:pokedex/utils/enums/pokemon_type.dart';

class PokemonTypesHelper {
  static String getTypeBackground(String type) {
    return "assets/images/pokemon_types/backgrounds/$type.jpg";
  }

  static String getTypeIcon(String type) {
    return "assets/images/pokemon_types/icons/$type.png";
  }

  static void precacheTypeImages(BuildContext context) {
    for (var type in PokemonTypeEnum.values) {
      precacheImage(AssetImage(getTypeBackground(type.name)), context);

      precacheImage(AssetImage(getTypeIcon(type.name)), context);
    }

    precacheImage(const AssetImage("assets/images/pokeball-background.png"), context);
  }

  static Color getTypeColor(String type) {
    return switch (type.toLowerCase()) {
      'bug' => const Color(0xFF90C12C),
      'dark' => const Color(0xFF5A5366),
      'dragon' => const Color(0xFF0A6DC4),
      'electric' => const Color(0xFFF7D02C),
      'fairy' => const Color(0xFFEC8FE6),
      'fighting' => const Color(0xFFC22E28),
      'fire' => const Color(0xFFFF9C54),
      'flying' => const Color(0xFF8FA8DD),
      'ghost' => const Color(0xFF5269AC),
      'grass' => const Color(0xFF63BB5B),
      'ground' => const Color(0xFFD97746),
      'ice' => const Color(0xFF74CEC0),
      'normal' => const Color(0xFF9099A1),
      'poison' => const Color(0xFFAB6AC8),
      'psychic' => const Color(0xFFF97176),
      'rock' => const Color(0xFFC7B78B),
      'steel' => const Color(0xFF5A8EA1),
      'water' => const Color(0xFF4D90D5),
      _ => Colors.grey
    };
  }

  String getTypeTextIcon(String type) {
    return switch (type.toLowerCase()) {
      'bug' => 'A',
      'dark' => 'B',
      'dragon' => 'C',
      'electric' => 'D',
      'fairy' => 'E',
      'fighting' => 'F',
      'fire' => 'G',
      'flying' => 'H',
      'ghost' => 'I',
      'grass' => 'J',
      'ground' => 'K',
      'ice' => 'L',
      'normal' => 'M',
      'poison' => 'N',
      'psychic' => 'O',
      'rock' => 'P',
      'steel' => 'Q',
      'water' => 'R',
      _ => 'A'
    };
  }
}