import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class JJLoader extends StatelessWidget {
  final double size;

  const JJLoader({
    super.key,
    this.size = 120.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const RiveAnimation.asset(
          'assets/joystick_junkie_logo.riv',
        ),
      ),
    );
  }
}
