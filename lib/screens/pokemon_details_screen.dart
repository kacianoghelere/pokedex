import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_details.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/utils/services/pokemon_service.dart';
import 'package:pokedex/widgets/pokemon_info_tab.dart';
import 'package:pokedex/widgets/evolution_chain_carousel.dart';
import 'package:pokedex/widgets/pokemon_moves_tab.dart';
import 'package:provider/provider.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailsScreen({
    super.key,
    required this.pokemon
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeProvider>(context).mode == ThemeMode.dark;

    final typeColor = pokemon.typeColor;

    final tabsColor = isDarkTheme
      ? HSLColor.fromColor(pokemon.typeColor).withLightness(0.6).toColor()
      : HSLColor.fromColor(pokemon.typeColor).withLightness(0.4).toColor();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              backgroundColor: typeColor,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  iconSize: 20,
                  icon: Icon(
                    pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
                    // color: Colors.white,
                  ),
                  onPressed: () {
                    Provider.of<PokemonProvider>(context, listen: false).toggleFavorite(pokemon);
                  },
                  padding: EdgeInsets.zero
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _getGradientColors(isDarkTheme),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0),
                    child: CachedNetworkImage(
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
                  ),
                ),
                centerTitle: true,
                title: Text(
                  toBeginningOfSentenceCase(pokemon.name),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      const Shadow(
                        blurRadius: 10,
                        color: Colors.black87,
                        offset: Offset(2.0, 2.0),
                      )
                    ]
                  )
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverTabBarDelegate(
                TabBar(
                  labelColor: tabsColor,
                  indicatorColor: tabsColor,
                  dividerHeight: 0,
                  unselectedLabelStyle: TextStyle(
                    color: Colors.grey.shade600
                  ),
                  tabs: const [
                    Tab(text: 'Info'),
                    Tab(text: 'Moves'),
                    Tab(text: 'Evolutions'),
                  ],
                ),
              ),
              pinned: true,
            ),
          ],
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

              return TabBarView(
                children: [
                  PokemonInfoTab(pokemon: pokemonDetails),
                  PokemonMovesTab(pokemon: pokemonDetails),
                  EvolutionChainCarrousel(evolutionChain: pokemonDetails.evolutionChain)
                ],
              );
            }
          ),
        )
      ),
    );
  }

  List<Color> _getGradientColors(bool isDarkTheme) {
    if (isDarkTheme) {
      return [
        pokemon.typeColor,
        HSLColor.fromColor(pokemon.typeColor).withLightness(0.3).toColor(),
        HSLColor.fromColor(pokemon.typeColor).withLightness(0.15).toColor(),
      ];
    }

    return [
      pokemon.typeColor,
      HSLColor.fromColor(pokemon.typeColor).withLightness(0.4).toColor(),
      HSLColor.fromColor(pokemon.typeColor).withLightness(0.3).toColor(),
    ];
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}