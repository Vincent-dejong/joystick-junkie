import 'package:flutter/material.dart';

class PlaceholderCover extends StatelessWidget {
  final double width;
  final double height;
  final double iconSize;
  final IconData icon;

  const PlaceholderCover({
    super.key,
    this.width = 200,
    this.height = 200,
    this.iconSize = 64,
    this.icon = Icons.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: Icon(
        icon,
        size: iconSize,
        color: Colors.grey,
      ),
    );
  }
}
