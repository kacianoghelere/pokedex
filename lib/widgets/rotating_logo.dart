import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RotatingLogo extends StatelessWidget {
  final Duration duration;
  final Curve curve;

  const RotatingLogo({
    super.key,
    this.duration = const Duration(seconds: 5),
    this.curve = Easing.standard,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Image.asset(
        'assets/images/pokeball-background.png',
        cacheHeight: 200,
        cacheWidth: 200,
        height: 200,
        filterQuality: FilterQuality.low,
        width: 200,
      ).animate(
        onPlay: (controller) => controller.repeat()
      ).rotate(
        curve: curve,
        delay: const Duration(milliseconds: 100),
        duration: duration,
      )
    );
  }
}