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
