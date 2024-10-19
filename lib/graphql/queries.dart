const String fetchFiltersDataQuery = r'''
query GetFiltersData {
  pokemon_v2_type {
    id
    name
  }
  pokemon_v2_generation {
    id
    name
  }
}
''';

const String fetchPokemonsQuery = r'''
query GetPokemons($where: pokemon_v2_pokemon_bool_exp) {
  pokemon: pokemon_v2_pokemon(where: $where) {
    id
    name
    types: pokemon_v2_pokemontypes {
      type: pokemon_v2_type {
        name
      }
    }
    sprites: pokemon_v2_pokemonsprites {
      front_default: sprites(path: "other.official-artwork.front_default")
    }
  }
}
''';

const String pokemonDetailQuery = r'''
query GetPokemonDetails($id: Int!) {
  pokemon: pokemon_v2_pokemon_by_pk(id: $id) {
    id
    name
    height
    weight
    base_experience

    # Types and weaknesses
    types: pokemon_v2_pokemontypes {
      type: pokemon_v2_type {
        name
        damage_relations: pokemon_v2_typeefficacies {
          damage_type: pokemon_v2_type {
            name
          }
          damage_factor # 100 = neutral, >100 = super-effective, <100 = not effective
        }
      }
    }

    # Abilities with effects and flavor texts
    abilities: pokemon_v2_pokemonabilities {
      ability: pokemon_v2_ability {
        name
        effects: pokemon_v2_abilityeffecttexts(
          limit: 1
          where: {pokemon_v2_language: {name: {_eq: "en"}}}
        ) {
          effect
        }
        flavor_texts: pokemon_v2_abilityflavortexts(
          limit: 1
          where: {pokemon_v2_language: {name: {_eq: "en"}}}
        ) {
          flavor_text
        }
      }
    }

    # Stats with min, max, and base values
    stats: pokemon_v2_pokemonstats_aggregate {
      aggregate {
        min {
          base_stat
        }
        max {
          base_stat
        }
        sum {
          base_stat
        }
      }
      nodes {
        base_stat
        stat: pokemon_v2_stat {
          stat_names: pokemon_v2_statnames(
            where: {pokemon_v2_language: {name: {_eq: "en"}}}
          ) {
            name
          }
        }
      }
    }

    # Moves learned through level-up
    moves: pokemon_v2_pokemonmoves_aggregate(
      where: {pokemon_v2_movelearnmethod: {name: {_eq: "level-up"}}}
      distinct_on: move_id
      order_by: {}
    ) {
      nodes {
        move: pokemon_v2_move {
          accuracy
          name
          flavor_texts: pokemon_v2_moveflavortexts(
            limit: 1
            where: {pokemon_v2_language: {name: {_eq: "en"}}}
          ) {
            flavor_text
          }
          move_names: pokemon_v2_movenames(
            limit: 1
            where: {pokemon_v2_language: {name: {_eq: "en"}}}
          ) {
            name
          }
          type: pokemon_v2_type {
            name
          }
        }
        level
      }
    }

    # Species, evolution chain, and evolution minimum levels
    species: pokemon_v2_pokemonspecy {
      capture_rate
      shape: pokemon_v2_pokemonshape {
        name
      }
      color: pokemon_v2_pokemoncolor {
        name
      }
      evolves_from_species_id
      flavor_texts: pokemon_v2_pokemonspeciesflavortexts(
        limit: 1
        where: {pokemon_v2_language: {name: {_eq: "en"}}}
      ) {
        flavor_text
      }
      evolution_chain: pokemon_v2_evolutionchain {
        species: pokemon_v2_pokemonspecies {
          name
          pokemons: pokemon_v2_pokemons {
            id
            name
            types: pokemon_v2_pokemontypes {
              type: pokemon_v2_type {
                name
              }
            }
            sprites: pokemon_v2_pokemonsprites {
              front_default: sprites(path: "other.official-artwork.front_default")
            }
          }
          evolutions: pokemon_v2_pokemonevolutions {
            min_affection
            min_happiness
            min_level
            evolved_species: pokemon_v2_pokemonspecy {
              name
            }
          }
        }
      }
    }

    # Sprites
    sprites: pokemon_v2_pokemonsprites {
      front_default: sprites(path: "other.official-artwork.front_default")
    }
  }
}
''';
