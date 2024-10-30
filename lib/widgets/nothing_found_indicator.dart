import 'package:flutter/material.dart';

class NothingFoundIndicator extends StatelessWidget {
  const NothingFoundIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/confused-pikachu.png",
              width: 200,
            ),
            Text(
              "Nothing found...",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
