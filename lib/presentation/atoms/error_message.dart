import 'package:flutter/material.dart';
import 'package:joystick_junkie/core/constants/jj_colors.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 8,
        children: [
          const Icon(
            Icons.warning,
            size: 40,
            color: JJColors.error,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
