import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/utils/helpers/pokemon_types_helper.dart';
import 'package:pokedex/utils/services/pokemon_service.dart';
import 'package:pokedex/widgets/pokemon_info_tab.dart';
import 'package:pokedex/widgets/pokemon_evolutions_tab.dart';
import 'package:pokedex/widgets/pokemon_moves_tab.dart';
import 'package:pokedex/widgets/pokemon_sprite.dart';
import 'package:provider/provider.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailsScreen({
    super.key,
    required this.pokemon
  });

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [
      const Tab(text: 'Info'),
      const Tab(text: 'Moves'),
      const Tab(text: 'Evolutions'),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            bool isDarkTheme = themeProvider.mode == ThemeMode.dark;

            final tabsColor = isDarkTheme
              ? HSLColor.fromColor(pokemon.typeColor).withLightness(0.6).toColor()
              : HSLColor.fromColor(pokemon.typeColor).withLightness(0.4).toColor();

            final headerColor = isDarkTheme
              ? HSLColor.fromColor(pokemon.typeColor).withLightness(0.25).toColor()
              : pokemon.typeColor;

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: headerColor,
                  iconTheme: const IconThemeData(color: Colors.white),
                  actions: [
                    IconButton(
                      iconSize: 20,
                      icon: Icon(
                        pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      onPressed: () {
                        Provider.of<PokemonProvider>(context, listen: false).toggleFavorite(pokemon);
                      },
                      padding: EdgeInsets.zero
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Positioned(
                          child: Opacity(
                            opacity: 0.8,
                            child: Image.asset(
                              PokemonTypesHelper.getTypeBackground(pokemon.types[0]),
                              width: MediaQuery.sizeOf(context).width,
                              height: 350,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 48.0),
                            child: PokemonSprite(
                              pokemon: pokemon,
                              size: 250,
                            )
                          ),
                        )
                      ],
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
                      tabs: tabs,
                    ),
                  ),
                  pinned: true,
                ),
              ],
              body: FutureBuilder<PokemonDetailsResponse>(
                future: PokemonService.fetchDetails(pokemon.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const _BackgroundBox(
                      child: CircularProgressIndicator()
                    );
                  }

                  if (snapshot.hasError || snapshot.data == null) {
                    return _renderFetchError();
                  }

                  var (pokemonDetails, exception) = snapshot.data!;

                  if (exception != null || pokemonDetails == null) {
                    return _renderFetchError();
                  }

                  return ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: TabBarView(
                      children: [
                        PokemonInfoTab(pokemon: pokemonDetails),
                        PokemonMovesTab(pokemon: pokemonDetails),
                        PokemonEvolutionsTab(pokemon: pokemonDetails)
                      ],
                    ),
                  );
                }
              ),
            );
          }
        )
      ),
    );
  }

  Widget _renderFetchError() {
    return const _BackgroundBox(
      child: Text('Error while loading pokemon data')
    );
  }
}

class _BackgroundBox extends StatelessWidget {
  final Widget child;

  const _BackgroundBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: child
      )
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar
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