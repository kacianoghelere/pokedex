import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:pokedex/graphql/queries.dart';
import 'package:pokedex/models/pokemon_model.dart';

class PokemonProvider with ChangeNotifier {
  List<Pokemon> _pokemons = [];
  final Box<Pokemon> _favoritesBox = Hive.box<Pokemon>('favorite_pokemons');

  List<Pokemon> get pokemons => _pokemons;

  List<Pokemon> get favorites => _favoritesBox.values.toList();

  Future<void> fetchPokemons(int generation, List<String> types) async {
    final client = GraphQLClient(
      link: HttpLink('https://beta.pokeapi.co/graphql/v1beta'),
      cache: GraphQLCache(),
    );

    final result = await client.query(QueryOptions(
      document: gql(fetchPokemonsQuery),
      // variables: {
      //   'generation': generation,
      //   'types': types
      // }
    ));

    if (result.hasException) {
      print("ERROR ${result.exception}");

      return;
    }

    _pokemons = (result.data?['pokemon_v2_pokemon'] as List)
      .map((data) => Pokemon(
        id: data['id'],
        name: data['name'],
        types: (data['pokemon_v2_pokemontypes'] as List)
            .map((t) => t['pokemon_v2_type']['name'] as String)
            .toList(),
        sprite: data['pokemon_v2_pokemonsprites'][0]['sprites']?['other']?['official-artwork']?['front_default'] ?? ''
      ))
      .toList();

    notifyListeners();
  }

  void toggleFavorite(Pokemon pokemon) {
    pokemon.isFavorite = !pokemon.isFavorite;

    if (pokemon.isFavorite) {
      _favoritesBox.put(pokemon.id, pokemon);
    } else {
      _favoritesBox.delete(pokemon.id);
    }

    notifyListeners();
  }
}
