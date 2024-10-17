import 'package:flutter/material.dart';

Color getTypeColor(String type) {
  return switch (type.toLowerCase()) {
    'bug' => const Color(0xFFA6B91A),
    'dark' => const Color(0xFF705746),
    'dragon' => const Color(0xFF6F35FC),
    'electric' => const Color(0xFFF7D02C),
    'fairy' => const Color(0xFFD685AD),
    'fighting' => const Color(0xFFC22E28),
    'fire' => const Color(0xFFEE8130),
    'flying' => const Color(0xFFA98FF3),
    'ghost' => const Color(0xFF735797),
    'grass' => const Color(0xFF7AC74C),
    'ground' => const Color(0xFFE2BF65),
    'ice' => const Color(0xFF96D9D6),
    'normal' => const Color(0xFFA8A77A),
    'poison' => const Color(0xFFA33EA1),
    'psychic' => const Color(0xFFF95587),
    'rock' => const Color(0xFFB6A136),
    'steel' => const Color(0xFFB7B7CE),
    'water' => const Color(0xFF6390F0),
    _ => Colors.grey
  };
}