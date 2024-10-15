import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/graphql/queries.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/type_colors.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('#${pokemon.id} ${pokemon.name}'),
          backgroundColor: getTypeColor(pokemon.types.first),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sobre'),
              Tab(text: 'Atributos'),
              Tab(text: 'Evoluções'),
            ]
          )
        ),
        body: Column(
          children: [
            Image.network(pokemon.sprite),
            FutureBuilder<QueryResult>(
              future: _fetchPokemonDetails(pokemon.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError || snapshot.data == null) {
                  return const Center(child: Text('Erro ao carregar dados.'));
                }

                final data = snapshot.data!.data!['pokemon_v2_pokemon_by_pk'];

                return Column(
                  children: [
                    TabBarView(
                      children: [
                        _aboutTab(data),
                        _baseStatsTab(data['pokemon_v2_pokemonstats']),
                        _evolutionTab(data['pokemon_v2_pokemonspecies']
                            ['pokemon_v2_evolutionchain']),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<QueryResult> _fetchPokemonDetails(int id) async {
    final client = GraphQLClient(
      link: HttpLink('https://beta.pokeapi.co/graphql/v1beta'),
      cache: GraphQLCache(),
    );

    return await client.query(QueryOptions(
      document: gql(pokemonDetailQuery),
      variables: {'id': id},
    ));
  }

  Widget _aboutTab(Map<String, dynamic> data) {
    final abilities = (data['pokemon_v2_pokemonabilities'] as List)
        .map((e) => e['pokemon_v2_ability']['name'])
        .join(', ');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailRow('Altura', '${data['height'] / 10} m'),
          _detailRow('Peso', '${data['weight'] / 10} kg'),
          _detailRow('Experiência Base', '${data['base_experience']}'),
          _detailRow('Habilidades', abilities),
        ],
      ),
    );
  }

  Widget _baseStatsTab(List<dynamic> stats) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stats.map((stat) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(stat['pokemon_v2_stat']['name']),
                Text(stat['base_stat'].toString()),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _evolutionTab(Map<String, dynamic> evolutionChain) {
    final evolutions = evolutionChain['pokemon_v2_pokemonspecies'] as List;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: evolutions.length,
      itemBuilder: (context, index) {
        final evolution = evolutions[index]['pokemon_v2_pokemons'][0];
        final name = evolutions[index]['name'];
        final sprite = evolution['pokemon_v2_pokemonsprites'][0]['sprites'];

        return ListTile(
          leading: Image.network(sprite),
          title: Text(name),
          onTap: () {
            final nextPokemon = Pokemon(
              id: evolution['id'],
              name: name,
              types: pokemon.types, // Usar os mesmos tipos como exemplo
              sprite: sprite,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokemonDetailScreen(pokemon: nextPokemon),
              ),
            );
          },
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
