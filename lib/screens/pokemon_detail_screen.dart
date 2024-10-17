import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/graphql/queries.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/utils/enums/pokemon_type.dart';
import 'package:pokedex/utils/format_helper.dart';
import 'package:pokedex/utils/pokemon_type_colors.dart';
import 'package:pokedex/widgets/evolution_chain_carousel.dart';
import 'package:pokedex/widgets/pokemon_type_icon.dart';
import 'package:provider/provider.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({
    super.key,
    required this.pokemon
  });

  @override
  Widget build(BuildContext context) {
    final typeColor = getTypeColor(pokemon.types.first);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              iconSize: 20,
              icon: Icon(
                pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                Provider.of<PokemonProvider>(context, listen: false).toggleFavorite(pokemon);
              },
              padding: EdgeInsets.zero
            )
          ],
          backgroundColor: typeColor,
          title: Text('#${pokemon.id} ${pokemon.name}'),
        ),
        body: FutureBuilder<QueryResult>(
          future: _fetchPokemonDetails(pokemon.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text('Error while loading pokemon data'));
            }

            final pokemonData = snapshot.data!.data!['pokemon'];

            final pokemonDetails = PokemonDetails.fromJson(pokemonData);

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: ColoredBox(
                    color: typeColor,
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          placeholder: (context, url) {
                            return const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            );
                          },
                          imageUrl: pokemon.sprite,
                          width: 150,
                          height: 150,
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 200,
                              child: ColoredBox(color: typeColor),
                            ),
                            SizedBox(
                              height: 24,
                              width: 200,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: typeColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: TabBar(
                    tabs: [
                      Tab(text: 'About'),
                      Tab(text: 'Attributes'),
                      Tab(text: 'Moves'),
                      Tab(text: 'Evolutions'),
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                children: [
                  AboutTab(data: pokemonData, pokemon: pokemon),
                  _baseStatsTab(pokemonData['stats']),
                  MovesTab(moves: pokemonData['moves']['nodes']),
                  EvolutionChainCarrousel(evolutionChain: pokemonDetails.evolutionChain)
                ],
              ),
            );
          },
        )
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
                Text(stat['stat']['stat_names'][0]['name']),
                Text(stat['base_stat'].toString()),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class TabWrapper extends StatelessWidget {
  final Widget child;

  const TabWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child
      )
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: textStyle!.copyWith(fontWeight: FontWeight.bold)
          ),
          Expanded(
            child: Text(
              value,
              style: textStyle
            )
          ),
        ],
      ),
    );
  }
}

class AboutTab extends StatelessWidget {
  final Pokemon pokemon;
  final Map<String, dynamic> data;

  const AboutTab({
    super.key,
    required this.pokemon,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    final abilities = (data['abilities'] as List)
      .map((e) => e['ability']['name'])
      .join(', ');

    return TabWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['species']['flavor_texts'][0]['flavor_text'].toString().replaceAll('\n', ' '),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontStyle: FontStyle.italic
            )
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Basic Stats',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold
              )
            ),
          ),
          DetailRow(label: 'Height', value: '${data['height'] / 10}m'),
          DetailRow(label: 'Weight', value: '${data['weight'] / 10}kg'),
          DetailRow(label: 'Base Experience', value: '${data['base_experience']}'),
          DetailRow(label: 'Abilities', value: abilities)
        ]
      ),
    );
  }
}

class MovesTab extends StatelessWidget {
  final List<dynamic> moves;

  const MovesTab({
    super.key,
    required this.moves
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: moves.map((item) {
          return ListTile(
            leading: PokemonTypeImage(
              PokemonTypeEnum.parse(item['move']['type']['name']),
              height: 24,
              width: 24,
            ),
            title: Text(
              item['move']['name'],
              style: const TextStyle(fontWeight: FontWeight.bold)
            ),
            subtitle: Text(
              formatFlavorText(item['move']['flavor_texts'][0]['flavor_text']),
              style: const TextStyle(fontStyle: FontStyle.italic)
            ),
            trailing: Text(item['level'].toString()),
          );
        }).toList(),
      ),
    );
  }
}
