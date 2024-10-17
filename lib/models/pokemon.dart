import 'package:hive/hive.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 1)
class Pokemon {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<String> types;

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
    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: (json['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList(),
      sprite: json['sprites'][0]['front_default'] ?? ''
    );
  }
}