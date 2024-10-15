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
  pokemon_v2_pokemon(where: $where) {
    id
    name
    pokemon_v2_pokemontypes {
      pokemon_v2_type {
        name
      }
    }
    pokemon_v2_pokemonsprites {
      sprites(path: "other.official-artwork.front_default")
    }
    pokemon_v2_pokemonspecy {
      pokemon_v2_generation {
        name
        id
      }
    }
  }
}
''';

const String pokemonDetailQuery = r'''
query GetPokemonDetails($id: Int!) {
  pokemon_v2_pokemon_by_pk(id: $id) {
    id
    name
    height
    weight
    base_experience
    pokemon_v2_pokemontypes {
      pokemon_v2_type {
        name
      }
    }
    pokemon_v2_pokemonabilities {
      pokemon_v2_ability {
        name
      }
    }
    pokemon_v2_pokemonstats {
      base_stat
      pokemon_v2_stat {
        name
      }
    }
    pokemon_v2_pokemonspecies {
      evolves_from_species_id
      evolution_chain_id
      pokemon_v2_evolutionchain {
        pokemon_v2_pokemonspecies {
          name
          pokemon_v2_pokemons {
            id
            pokemon_v2_pokemonsprites {
              sprites
            }
          }
        }
      }
    }
  }
}
''';
