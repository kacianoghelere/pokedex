enum PokemonTypeEnum {
  bug,
  dark,
  dragon,
  electric,
  fairy,
  fighting,
  fire,
  flying,
  ghost,
  grass,
  ground,
  ice,
  normal,
  poison,
  psychic,
  rock,
  steel,
  water;

  static PokemonTypeEnum parse(String pokemonType) {
    return switch (pokemonType) {
      'bug' => PokemonTypeEnum.bug,
      'dark' => PokemonTypeEnum.dark,
      'dragon' => PokemonTypeEnum.dragon,
      'electric' => PokemonTypeEnum.electric,
      'fairy' => PokemonTypeEnum.fairy,
      'fighting' => PokemonTypeEnum.fighting,
      'fire' => PokemonTypeEnum.fire,
      'flying' => PokemonTypeEnum.flying,
      'ghost' => PokemonTypeEnum.ghost,
      'grass' => PokemonTypeEnum.grass,
      'ground' => PokemonTypeEnum.ground,
      'ice' => PokemonTypeEnum.ice,
      'normal' => PokemonTypeEnum.normal,
      'poison' => PokemonTypeEnum.poison,
      'psychic' => PokemonTypeEnum.psychic,
      'rock' => PokemonTypeEnum.rock,
      'steel' => PokemonTypeEnum.steel,
      'water' => PokemonTypeEnum.water,
      _ => throw ArgumentError('Invalid pokemonType name')
    };
  }
}

extension PokemonTypeExtension on PokemonTypeEnum {
  String get name {
    return switch (this) {
      PokemonTypeEnum.bug => 'bug',
      PokemonTypeEnum.dark => 'dark',
      PokemonTypeEnum.dragon => 'dragon',
      PokemonTypeEnum.electric => 'electric',
      PokemonTypeEnum.fairy => 'fairy',
      PokemonTypeEnum.fighting => 'fighting',
      PokemonTypeEnum.fire => 'fire',
      PokemonTypeEnum.flying => 'flying',
      PokemonTypeEnum.ghost => 'ghost',
      PokemonTypeEnum.grass => 'grass',
      PokemonTypeEnum.ground => 'ground',
      PokemonTypeEnum.ice => 'ice',
      PokemonTypeEnum.normal => 'normal',
      PokemonTypeEnum.poison => 'poison',
      PokemonTypeEnum.psychic => 'psychic',
      PokemonTypeEnum.rock => 'rock',
      PokemonTypeEnum.steel => 'steel',
      PokemonTypeEnum.water => 'water'
    };
  }
}