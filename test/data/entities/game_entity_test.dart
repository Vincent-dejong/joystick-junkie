import 'package:flutter_test/flutter_test.dart';
import 'package:joystick_junkie/data/entities/game_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late MockIGDBImageUrlHelper mockIGDBImageUrlHelper;

  setUp(() {
    mockIGDBImageUrlHelper = MockIGDBImageUrlHelper();
  });

  group('GameEntity', () {
    const gameJson = {
      'id': 1,
      'name': 'Test Game',
      'cover': {'url': 'cover_image_url'},
      'summary': 'A test game description',
      'rating': 4.5,
      'rating_count': 100,
      'storyline': 'A test game storyline',
      'first_release_date': 1630000000,
    };

    var expectedGameEntity = GameEntity(
      id: 1,
      name: 'Test Game',
      coverImageUrl: 'parsed_cover_image_url',
      summary: 'A test game description',
      rating: 4.5,
      ratingCount: 100,
      storyline: 'A test game storyline',
      firstReleaseDate: DateTime.fromMillisecondsSinceEpoch(1630000000 * 1000),
    );

    test('should parse JSON correctly', () {
      // Arrange
      when(() => mockIGDBImageUrlHelper.parseUrl('cover_image_url'))
          .thenReturn('parsed_cover_image_url');

      // Act
      final result = GameEntity.fromJson(
        gameJson,
        urlHelper: mockIGDBImageUrlHelper,
      );

      // Assert
      expect(result, equals(expectedGameEntity));
      verify(() => mockIGDBImageUrlHelper.parseUrl('cover_image_url')).called(1);
    });

    test('should handle null cover image', () {
      // Arrange
      const incompleteJson = {
        'id': 2,
        'name': 'Incomplete Game',
        'cover': null,
        'summary': null,
        'rating': null,
        'rating_count': null,
        'storyline': null,
        'first_release_date': null,
      };

      const expectedEntity = GameEntity(
        id: 2,
        name: 'Incomplete Game',
        coverImageUrl: null,
        summary: null,
        rating: null,
        ratingCount: null,
        storyline: null,
        firstReleaseDate: null,
      );

      // Act
      final result = GameEntity.fromJson(
        incompleteJson,
        urlHelper: mockIGDBImageUrlHelper,
      );

      // Assert
      expect(result, equals(expectedEntity));
      verifyNever(() => mockIGDBImageUrlHelper.parseUrl(any()));
    });
  });
}
