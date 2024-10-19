import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/graphql/queries.dart';

class PokemonService {
  static final _graphQlClient = GraphQLClient(
    link: HttpLink('https://beta.pokeapi.co/graphql/v1beta'),
    cache: GraphQLCache(),
  );

  static Future<QueryResult> fetchDetails(int id) async {
    return await _graphQlClient.query(QueryOptions(
      document: gql(pokemonDetailQuery),
      variables: {'id': id},
    ));
  }

  static Future<QueryResult> fetchFilters() async {
    return await _graphQlClient.query(QueryOptions(
      document: gql(fetchFiltersDataQuery)
    ));
  }

  static Future<QueryResult> fetchList(Map<String, dynamic>? where) async {
    return await _graphQlClient.query(QueryOptions(
      document: gql(fetchPokemonsQuery),
      variables: {
        'where': where == null || where.isEmpty ? null : where
      }
    ));
  }
}