import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:pokedex/graphql/queries.dart';
import 'package:pokedex/models/generation.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_type.dart';

class PokemonProvider with ChangeNotifier {
  final Box<Pokemon> _favoritesBox = Hive.box<Pokemon>('favorite_pokemons');
  List<Pokemon> _pokemons = [];

  List<Pokemon> get pokemons => _pokemons;

  List<Pokemon> get favorites => _favoritesBox.values.toList();

  Future<void> fetchPokemons({
    required List<Generation> generations,
    required List<PokemonType> pokemonTypes
  }) async {
    // Build the `where` filter dynamically
    final Map<String, dynamic> where = {};

    // Add generation filter only if `generationIds` is not empty
    if (generations.isNotEmpty) {
      var generationIds = generations.map((item) => item.id).toList();

      where['pokemon_v2_pokemonspecy'] = {
        'generation_id': {'_in': generationIds},
      };
    }

    // Add type filter only if `types` is not empty
    if (pokemonTypes.isNotEmpty) {
      var types = pokemonTypes.map((item) => item.type).toList();

      where['pokemon_v2_pokemontypes'] = {
        'pokemon_v2_type': {'name': {'_in': types}}
      };
    }

    if (kDebugMode) {
      debugPrint("fetchPokemons params ${where.toString()}");
    }

    // Initialize GraphQL client
    final client = GraphQLClient(
      link: HttpLink('https://beta.pokeapi.co/graphql/v1beta'),
      cache: GraphQLCache(),
    );

    // Execute the query with the dynamically built `where` filter
    final QueryOptions options = QueryOptions(
      document: gql(fetchPokemonsQuery),
      variables: {
        'where': where.isEmpty ? null : where
      }
    );

    final result = await client.query(options);

    if (result.hasException) {
      if (kDebugMode) {
        debugPrint("fetchPokemons ${result.exception}");
      }

      return;
    }

    _pokemons = (result.data?['pokemon'] as List)
      .map((data) => Pokemon.fromJson(data))
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
