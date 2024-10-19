import 'package:flutter/material.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      color: Colors.white,
      key: const Key('TOGGLE_THEME'),
      icon: Icon(
        themeProvider.mode == ThemeMode.dark
          ? Icons.light_mode
          : Icons.dark_mode,
      ),
      onPressed: () {
        themeProvider.toggleMode();
      },
    );
  }
}
