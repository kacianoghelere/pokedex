import 'package:flutter/material.dart';
import 'package:pokedex/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeProvider>(context).mode == ThemeMode.dark;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ColoredBox(
        color: isDarkTheme
          ? const Color.fromRGBO(10, 10, 10, 1)
          : const Color.fromRGBO(250, 250, 250, 1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w700
            )
          ),
        ),
      ),
    );
  }
}