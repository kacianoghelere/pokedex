import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/utils/pokemon_type_colors.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 1)
class Pokemon {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<PokemonType> types;

  @HiveField(3)
  final String sprite;

  @HiveField(4)
  bool isFavorite;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.sprite,
    this.isFavorite = false,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
      .map((data) => PokemonType.fromJson(data))
      .toList();

    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: types,
      sprite: json['sprites'][0]['front_default'] ?? ''
    );
  }

  Color get typeColor {
    return getTypeColor(types[0].name);
  }
}