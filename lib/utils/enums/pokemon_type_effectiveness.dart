enum PokemonTypeEffectivenessEnum {
  resistant,
  neutral,
  vulnerable;

  static PokemonTypeEffectivenessEnum parse(int score) {
    return switch (score) {
      > 0 => PokemonTypeEffectivenessEnum.resistant,
      < 0 => PokemonTypeEffectivenessEnum.vulnerable,
      _ => PokemonTypeEffectivenessEnum.neutral
    };
  }
}

extension PokemonTypeEffectivenessEnumExtension on PokemonTypeEffectivenessEnum {
  int get score {
    return switch (this) {
      PokemonTypeEffectivenessEnum.resistant => 1,
      PokemonTypeEffectivenessEnum.neutral => 0,
      PokemonTypeEffectivenessEnum.vulnerable => -1
    };
  }
}