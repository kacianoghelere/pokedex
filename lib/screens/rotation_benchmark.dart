import 'package:flutter/material.dart';
import 'package:pokedex/widgets/rotating_logo.dart';

class RotationBenchmark extends StatelessWidget {
  const RotationBenchmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Rotation Animation'),
      ),
      body: const Center(
        child: Opacity(
          opacity: 0.5,
          child: RotatingLogo(
            curve: Easing.standard,
            duration: Duration(seconds: 1),
          ),
        )
      ),
    );
  }
}