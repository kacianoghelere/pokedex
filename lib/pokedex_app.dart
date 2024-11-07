import 'package:flutter/material.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/features/home/screens/home_screen.dart';
import 'package:pokedex/utils/helpers/pokemon_types_helper.dart';
import 'package:pokedex/utils/theme.dart';
import 'package:provider/provider.dart';

class PokedexApp extends StatefulWidget {
  const PokedexApp({super.key});

  @override
  State<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends State<PokedexApp> {
  @override
  initState() {
    Provider.of<FilterProvider>(context, listen: false).fetchFilterData();

    Provider.of<ThemeProvider>(context, listen: false).loadTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      title: 'Pokédex',
      themeMode: themeProvider.mode,
      darkTheme: PokedexAppTheme.darkTheme,
      theme: PokedexAppTheme.lightTheme,
      builder: (context, widget) {
        PokemonTypesHelper.precacheTypeImages(context);

        return widget ?? const SizedBox.shrink();
      },
      home: const HomeScreen(),
    );
  }
}
