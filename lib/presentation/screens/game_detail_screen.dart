import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:joystick_junkie/domain/models/game.dart';
import 'package:joystick_junkie/presentation/atoms/placeholder_cover.dart';
import 'package:joystick_junkie/presentation/atoms/rating.dart';
import 'package:joystick_junkie/presentation/atoms/titled_description.dart';

class GameDetailScreen extends StatelessWidget {
  static const double headerHeight = 200.0;
  final Game game;

  const GameDetailScreen({super.key, required this.game});

  String formatDate(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Hero(
                  tag: game.id,
                  child: game.coverImageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: game.coverImageUrl!,
                          width: double.infinity,
                          height: headerHeight,
                          fit: BoxFit.cover,
                        )
                      : const PlaceholderCover(
                          height: headerHeight,
                          width: double.infinity,
                        ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    game.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  if (game.rating != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Rating(rating: game.rating!, ratingCount: game.ratingCount),
                        if (game.firstReleaseDate != null)
                          Text(formatDate(game.firstReleaseDate!.toLocal())),
                      ],
                    ),
                  if (game.summary != null)
                    TitledDescription(title: 'Summary', description: game.summary!),
                  if (game.storyline != null)
                    TitledDescription(title: 'Storyline', description: game.storyline!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
