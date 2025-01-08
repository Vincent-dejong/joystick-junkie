import 'package:equatable/equatable.dart';
import 'package:joystick_junkie/data/entities/game_entity.dart';

class Game extends Equatable {
  final int id;
  final String name;
  final String? coverImageUrl;
  final String? summary;
  final String? storyline;
  final double? rating;
  final int? ratingCount;
  final DateTime? firstReleaseDate;

  const Game({
    required this.id,
    required this.name,
    this.coverImageUrl,
    this.summary,
    this.storyline,
    this.rating,
    this.ratingCount,
    this.firstReleaseDate,
  });

  factory Game.fromEntity(GameEntity entity) => Game(
        id: entity.id,
        name: entity.name,
        coverImageUrl: entity.coverImageUrl,
        summary: entity.summary,
        storyline: entity.storyline,
        rating: entity.rating,
        ratingCount: entity.ratingCount,
        firstReleaseDate: entity.firstReleaseDate,
      );

  GameEntity toEntity() => GameEntity(
        id: id,
        name: name,
        coverImageUrl: coverImageUrl,
        summary: summary,
        storyline: storyline,
        rating: rating,
        ratingCount: ratingCount,
        firstReleaseDate: firstReleaseDate,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        coverImageUrl,
        summary,
        storyline,
        rating,
        ratingCount,
        firstReleaseDate,
      ];
}
