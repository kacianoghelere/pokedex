import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'package:pokedex/utils/extensions/color_extension.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDir = await getApplicationDocumentsDirectory();

  await Hive.initFlutter(appDir.path);

  Hive.registerAdapter(PokemonAdapter());

  await Hive.openBox<Pokemon>('favorite_pokemons');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ],
      child: const MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();

    final filterProvider = Provider.of<FilterProvider>(context, listen: false);

    filterProvider.fetchFilterData();
  }

  @override
  Widget build(BuildContext context) {
    var color = const Color.fromRGBO(204, 0, 0, 1);

    var darkColor = HSLColor.fromColor(color).withLightness(0.25).toColor();

    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Pokédex',
      themeMode: themeProvider.mode,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: darkColor,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.black
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        primaryColor: darkColor.toMaterialColor(),
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: color
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        primaryColor: color,
        primarySwatch: color.toMaterialColor(),
      ),
      home: const HomeScreen(),
    );
  }
}
