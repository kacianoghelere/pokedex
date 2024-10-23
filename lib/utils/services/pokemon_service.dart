import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/graphql/queries.dart';
import 'package:pokedex/models/pokemon_generation.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/models/pokemon_type.dart';

typedef _Response<T extends Object> = (T? result, Exception? exception);

typedef GqlResponse = _Response<QueryResult>;

typedef PokemonDetailsResponse = _Response<PokemonDetails>;

typedef PokemonListResponse = _Response<List<Pokemon>>;

typedef PokemonFiltersResponse = _Response<(
  List<PokemonGeneration> generations,
  List<PokemonType> types
)>;

class PokemonService {
  static final _graphQlClient = GraphQLClient(
    link: HttpLink('https://beta.pokeapi.co/graphql/v1beta'),
    cache: GraphQLCache(),
  );

  static Future<GqlResponse> _executeQuery(QueryOptions queryOptions) async {
    try {
      final result = await _graphQlClient.query(queryOptions);

      if (result.hasException) {
        throw Exception(result.exception);
      }

      return (result, null);
    } on Exception catch (exception) {
      return (null, exception);
    }
  }

  static Future<PokemonDetailsResponse> fetchDetails(int id) async {
    var response = await _executeQuery(QueryOptions(
      document: gql(pokemonDetailQuery),
      variables: {'id': id},
    ));

    var (result, exception) = response;

    if (exception != null) {
      return (null, exception);
    }

    if (result?.data == null || result?.data?['pokemon'] == null) {
      return (null, Exception('Empty pokemon data'));
    }

    return (PokemonDetails.fromJson(result!.data!['pokemon']), exception);
  }

  static Future<PokemonFiltersResponse> fetchFilters() async {
    var response = await _executeQuery(QueryOptions(
      document: gql(fetchFiltersDataQuery)
    ));

    var (result, exception) = response;

    if (exception != null) {
      return (null, exception);
    }

    if (result?.data?['pokemon_v2_type'] == null) {
      return (null, Exception('Empty pokemon type filters'));
    }

    if (result?.data?['pokemon_v2_generation'] == null) {
      return (null, Exception('Empty pokemon generation filters'));
    }

    var types = (result?.data?['pokemon_v2_type'] as List)
      .map((data) => PokemonType.fromJson(data))
      .toList();

    var generations = (result?.data?['pokemon_v2_generation'] as List)
      .map((data) => PokemonGeneration.fromJson(data))
      .toList();

    return ((generations, types), null);
  }

  static Future<PokemonListResponse> fetchList(Map<String, dynamic>? where) async {
    var response = await _executeQuery(QueryOptions(
      document: gql(fetchPokemonsQuery),
      variables: {
        'where': where == null || where.isEmpty ? null : where
      }
    ));

    var (result, exception) = response;

    if (exception != null) {
      return (null, exception);
    }

    if (result?.data?['pokemon'] == null) {
      return (null, Exception('Empty pokemon list'));
    }

    var pokemons = (result!.data!['pokemon'] as List)
      .map((data) => Pokemon.fromJson(data))
      .toList();

    return (pokemons, null);
  }
}