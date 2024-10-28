import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/utils/helpers/pokemon_types_helper.dart';
import 'package:pokedex/utils/services/pokemon_service.dart';
import 'package:pokedex/widgets/pokemon_info_tab.dart';
import 'package:pokedex/widgets/pokemon_evolutions_tab.dart';
import 'package:pokedex/widgets/pokemon_moves_tab.dart';
import 'package:pokedex/widgets/pokemon_sprite.dart';
import 'package:pokedex/widgets/rotating_logo.dart';
import 'package:pokedex/widgets/toggle_favorite_pokemon_button.dart';
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
            final hslColor = HSLColor.fromColor(pokemon.typeColor);

            final tabsColor = themeProvider.isDarkMode
              ? hslColor.withLightness(0.6).toColor()
              : hslColor.withLightness(0.4).toColor();

            final headerColor = themeProvider.isDarkMode
              ? hslColor.withLightness(0.25).toColor()
              : pokemon.typeColor;

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  backgroundColor: headerColor,
                  expandedHeight: 300.0,
                  floating: false,
                  iconTheme: const IconThemeData(color: Colors.white),
                  pinned: true,
                  actions: [
                    ToggleFavoritePokemonButton(pokemon: pokemon)
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: _HeaderBackground(pokemon: pokemon),
                    centerTitle: true,
                    // title: Text(
                    //   toBeginningOfSentenceCase(pokemon.name),
                    //   style: _getTitleStyle(context)
                    // ),
                    title: Builder(
                      builder: (context) {
                        return Text(
                          toBeginningOfSentenceCase(pokemon.name) ?? 'Unknown Pokémon',
                          style: _getTitleStyle(context),
                        );
                      },
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverTabBarDelegate(
                    TabBar(
                      dividerHeight: 1,
                      dividerColor: themeProvider.isDarkMode
                        ? Colors.grey.shade600
                        : Colors.grey.shade200,
                      indicatorColor: tabsColor,
                      indicator: ShapeDecoration(
                        shape: const CircleBorder(),
                        image: DecorationImage(
                          image: const AssetImage("assets/images/pokeball-background.png"),
                          opacity: 0.2,
                          colorFilter: ColorFilter.mode(pokemon.typeColor, BlendMode.srcIn)
                        ),
                      ),
                      indicatorPadding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3.0,
                      labelColor: tabsColor,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            blurRadius: 1,
                            color: Colors.white12,
                            offset: Offset(0, 0),
                          )
                        ]
                      ),
                      unselectedLabelStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.normal,
                        fontSize: 16
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
                      child: Opacity(
                        opacity: 0.3,
                        child: RotatingLogo(
                          duration: Durations.extralong4,
                          curve: Easing.standard
                        )
                      )
                    );
                  }

                  if (snapshot.hasError && snapshot.data == null) {
                    return _renderErrorAlert();
                  }

                  var (pokemonDetails, exception) = snapshot.data!;

                  return ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: TabBarView(
                      children: [
                        PokemonInfoTab(pokemon: pokemonDetails!),
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

  TextStyle _getTitleStyle(BuildContext context) {
    final style = (Theme.of(context).textTheme.titleLarge ?? const TextStyle());

    return style.copyWith(
      color: Colors.white, // Fallback para cor branca.
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      shadows: [
        const Shadow(
          blurRadius: 10,
          color: Colors.black87,
          offset: Offset(2.0, 2.0),
        ),
      ],
    );
  }

  Widget _renderErrorAlert() {
    return const _BackgroundBox(
      child: Text('Error while loading pokemon data')
    );
  }
}

class _HeaderBackground extends StatelessWidget {
  final Pokemon pokemon;

  const _HeaderBackground({required this.pokemon});

  @override
  Widget build(BuildContext context) {
        return Stack(
      children: [
        Positioned(
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              PokemonTypesHelper.getTypeBackground(pokemon.mainType.type),
              width: MediaQuery.sizeOf(context).width,
              height: 500,
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
    );
  }
}

class _BackgroundBox extends StatelessWidget {
  final Widget child;

  const _BackgroundBox({required this.child});

  @override
  Widget build(BuildContext context) {
    var hslColor = HSLColor.fromColor(Theme.of(context).scaffoldBackgroundColor);

    return ColoredBox(
      color: hslColor.withLightness(0.92).toColor(),
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

  double get preferredSize => tabBar.preferredSize.height;

  @override
  double get maxExtent => preferredSize;

  @override
  double get minExtent => preferredSize;

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}