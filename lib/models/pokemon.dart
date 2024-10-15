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

  Pokemon.fromJson(Map<String, dynamic> json):
    this(
      id: json['id'],
      name: json['name'],
      types: (json['pokemon_v2_pokemontypes'] as List)
        .map((t) => t['pokemon_v2_type']['name'] as String)
        .toList(),
      sprite: json['pokemon_v2_pokemonsprites'][0]['sprites'] ?? ''
    );
}
