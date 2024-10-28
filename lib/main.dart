import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'package:pokedex/utils/extensions/color_extension.dart';
import 'package:pokedex/utils/helpers/pokemon_types_helper.dart';
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

    Provider.of<FilterProvider>(context, listen: false).fetchFilterData();
    
    Provider.of<ThemeProvider>(context, listen: false).loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    var color = const Color.fromRGBO(204, 0, 0, 1);

    var darkColor = HSLColor.fromColor(color).withLightness(0.25).toColor();

    final themeProvider = Provider.of<ThemeProvider>(context);

    // TODO: Fix dark theme issue with titles
    var textThemeData = const TextTheme(
      headlineLarge: TextStyle(fontFamily: 'Poppins'),
      headlineMedium: TextStyle(fontFamily: 'Poppins'),
      headlineSmall: TextStyle(fontFamily: 'Poppins'),
      titleLarge: TextStyle(fontFamily: 'Poppins'),
      titleMedium: TextStyle(fontFamily: 'Poppins'),
      titleSmall: TextStyle(fontFamily: 'Poppins'),
    );

    return MaterialApp(
      title: 'Pokédex',
      themeMode: themeProvider.mode,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: darkColor,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey.shade900
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        primaryColor: darkColor.toMaterialColor(),
        scaffoldBackgroundColor: Colors.black,
        listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(color: Colors.white),
          subtitleTextStyle: TextStyle(color: Colors.white70),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          titleSmall: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: color
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey.shade100
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        primaryColor: color,
        primarySwatch: color.toMaterialColor(),
        scaffoldBackgroundColor: Colors.white,
        listTileTheme: const ListTileThemeData(
          minTileHeight: 32
        ),
        textTheme: textThemeData
      ),
      builder: (context, widget) {
        PokemonTypesHelper.precacheTypeImages(context);

        return widget ?? const SizedBox.shrink();
      },
      home: const HomeScreen(),
    );
  }
}
