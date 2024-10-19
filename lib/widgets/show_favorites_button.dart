import 'package:flutter/material.dart';
import 'package:pokedex/providers/filter_provider.dart';
import 'package:provider/provider.dart';

class ShowFavoritesButton extends StatelessWidget {
  const ShowFavoritesButton({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    return IconButton(
      icon: Icon(
        color: Colors.white,
        filterProvider.showFavoritesOnly
            ? Icons.favorite
            : Icons.favorite_border,
      ),
      onPressed: () {
        filterProvider.toggleFavoritesOnly();
      },
    );
  }
}