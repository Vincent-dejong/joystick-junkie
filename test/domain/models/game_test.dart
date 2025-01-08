import 'package:flutter_test/flutter_test.dart';
import 'package:joystick_junkie/data/entities/game_entity.dart';
import 'package:joystick_junkie/domain/models/game.dart';

void main() {
  group('Game', () {
    final gameEntity = GameEntity(
      id: 1,
      name: 'Test Game',
      coverImageUrl: 'https://example.com/image.jpg',
      summary: 'A test game description',
      storyline: 'A test game storyline',
      rating: 4.5,
      ratingCount: 100,
      firstReleaseDate: DateTime(2025, 1, 1),
    );

    final gameModel = Game(
      id: 1,
      name: 'Test Game',
      coverImageUrl: 'https://example.com/image.jpg',
      summary: 'A test game description',
      storyline: 'A test game storyline',
      rating: 4.5,
      ratingCount: 100,
      firstReleaseDate: DateTime(2025, 1, 1),
    );

    test('should correctly map from GameEntity to Game', () {
      // Act
      final result = Game.fromEntity(gameEntity);

      // Assert
      expect(result, equals(gameModel));
    });

    test('should correctly map from Game to GameEntity', () {
      // Act
      final result = gameModel.toEntity();

      // Assert
      expect(result, equals(gameEntity));
    });

    test('should correctly compare two Game instances with Equatable', () {
      // Arrange
      var anotherGameModel = Game(
        id: 1,
        name: 'Test Game',
        coverImageUrl: 'https://example.com/image.jpg',
        summary: 'A test game description',
        storyline: 'A test game storyline',
        rating: 4.5,
        ratingCount: 100,
        firstReleaseDate: DateTime(2025, 1, 1),
      );

      // Assert
      expect(gameModel, equals(anotherGameModel));
    });

    test('should correctly differentiate between different Game instances', () {
      // Arrange
      const anotherGameModel = Game(
        id: 2,
        name: 'Another Game',
        coverImageUrl: 'https://example.com/another-image.jpg',
        summary: 'Another game description',
        rating: 3.5,
      );

      // Assert
      expect(gameModel, isNot(equals(anotherGameModel)));
    });

    test('should return correct props for Equatable', () {
      // Act
      final props = gameModel.props;

      // Assert
      expect(
        props,
        equals([
          gameModel.id,
          gameModel.name,
          gameModel.coverImageUrl,
          gameModel.summary,
          gameModel.storyline,
          gameModel.rating,
          gameModel.ratingCount,
          gameModel.firstReleaseDate,
        ]),
      );
    });
  });
}
