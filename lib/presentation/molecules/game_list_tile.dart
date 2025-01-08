import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joystick_junkie/domain/models/game.dart';
import 'package:joystick_junkie/presentation/atoms/placeholder_cover.dart';
import 'package:joystick_junkie/presentation/atoms/rating.dart';
import 'package:joystick_junkie/presentation/screens/game_detail_screen.dart';

class GameListTile extends StatelessWidget {
  static const double thumbnailWidth = 120.0;
  static const double thumbnailPlaceholderHeight = 150.0;
  final Game game;

  const GameListTile({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GameDetailScreen(game: game),
                ),
              );
            },
            child: Row(
              children: [
                Hero(
                  tag: game.id,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: game.coverImageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: game.coverImageUrl!,
                            width: thumbnailWidth,
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          )
                        : const PlaceholderCover(
                            width: thumbnailWidth,
                            height: thumbnailPlaceholderHeight,
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(game.name, style: Theme.of(context).textTheme.titleMedium),
                        ),
                        if (game.rating != null)
                          Rating(
                            rating: game.rating!,
                            ratingCount: game.ratingCount,
                          ),
                        if (game.summary != null)
                          Flexible(
                            child: Text(
                              game.summary!,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            )
            // Column(
            //   children: [
            //
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Flexible(
            //                 child: Text(game.name, style: Theme.of(context).textTheme.titleMedium),
            //               ),
            //               if (game.rating != null)
            //                 Rating(
            //                   rating: game.rating!,
            //                   ratingCount: game.ratingCount,
            //                 ),
            //             ],
            //           ),
            //           if (game.summary != null)
            //             Text(
            //               game.summary!,
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //               style: Theme.of(context).textTheme.bodyMedium,
            //             ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }
}
