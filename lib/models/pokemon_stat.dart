class PokemonStat {
  final String name;
  final int value;

  PokemonStat({
    required this.name,
    required this.value,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      name: json['stat']['stat_names'][0]['name'],
      value: json['base_stat']
    );
  }
}