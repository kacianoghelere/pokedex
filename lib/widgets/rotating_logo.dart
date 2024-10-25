import 'package:flutter/material.dart';

class RotatingLogo extends StatefulWidget {
  final Duration duration;
  final Curve curve;

  const RotatingLogo({
    super.key,
    Duration? duration,
    Curve? curve,
  }): duration = duration ?? const Duration(seconds: 5),
    curve = curve ?? Easing.linear;

  @override
  State<RotatingLogo> createState() => _RotatingLogoState();
}

class _RotatingLogoState extends State<RotatingLogo>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: _animation,
          filterQuality: FilterQuality.none,
          child: Image.asset(
            'assets/images/pokeball-background.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}