import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;
  final int? ratingCount;

  const Rating({
    super.key,
    required this.rating,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    // Convert rating to a 1-5 scale based on the maximum rating of 100.0
    int fullStars = (rating / 20).floor();
    bool hasHalfStar = (rating % 20) >= 10;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          5,
          (index) {
            if (index < fullStars) {
              return const Icon(
                Icons.star,
                color: Colors.amber,
                size: 16,
              );
            } else if (index == fullStars && hasHalfStar) {
              return const Icon(
                Icons.star_half,
                color: Colors.amber,
                size: 16,
              );
            } else {
              return const Icon(
                Icons.star_border,
                color: Colors.amber,
                size: 16,
              );
            }
          },
        ),
        const SizedBox(width: 4),
        if (ratingCount != null)
          Text(
            '($ratingCount)',
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}
