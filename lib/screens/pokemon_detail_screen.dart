import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/utils/pokemon_type_colors.dart';
import 'package:pokedex/utils/services/pokemon_service.dart';
import 'package:pokedex/widgets/pokemon_info_tab.dart';
import 'package:pokedex/widgets/evolution_chain_carousel.dart';
import 'package:pokedex/widgets/pokemon_moves_tab.dart';
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
      length: 3,
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
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '#${pokemon.id} ',
                ),
                TextSpan(
                  text: toBeginningOfSentenceCase(pokemon.name),
                  style: const TextStyle(fontWeight: FontWeight.bold)
                )
              ]
            )
          ),
        ),
        body: FutureBuilder<QueryResult>(
          future: PokemonService.fetchDetails(pokemon.id),
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
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          typeColor,
                          typeColor,
                          HSLColor.fromColor(typeColor).withLightness(0.5).toColor(),
                        ],
                      )
                    ),
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
                      Tab(text: 'Info'),
                      Tab(text: 'Moves'),
                      Tab(text: 'Evolutions'),
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                children: [
                  PokemonInfoTab(pokemon: pokemonDetails),
                  PokemonMovesTab(pokemon: pokemonDetails),
                  EvolutionChainCarrousel(evolutionChain: pokemonDetails.evolutionChain)
                ],
              ),
            );
          },
        )
      ),
    );
  }
}
