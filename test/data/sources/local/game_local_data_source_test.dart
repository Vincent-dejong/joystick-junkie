import 'package:flutter_test/flutter_test.dart';
import 'package:joystick_junkie/data/entities/game_entity.dart';
import 'package:joystick_junkie/data/sources/local/game_local_data_source.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockAppDatabase mockDatabase;
  late MockGameDao mockGameDao;
  late GameLocalDataSource localDataSource;

  setUp(() {
    mockDatabase = MockAppDatabase();
    mockGameDao = MockGameDao();
    when(() => mockDatabase.gameDao).thenReturn(mockGameDao);
    localDataSource = GameLocalDataSource(database: mockDatabase);
  });

  group('GameLocalDataSource', () {
    final mockGameEntities = [
      const GameEntity(
        id: 1,
        name: 'Test Game 1',
        coverImageUrl: 'url1',
        summary: 'Description 1',
        rating: 4.5,
      ),
      const GameEntity(
        id: 2,
        name: 'Test Game 2',
        coverImageUrl: 'url2',
        summary: 'Description 2',
        rating: 3.5,
      ),
    ];

    test('should save game entities to the database', () async {
      // Arrange
      when(() => mockGameDao.insertGames(mockGameEntities)).thenAnswer((_) async {});

      // Act
      await localDataSource.saveGameEntities(mockGameEntities);

      // Assert
      verify(() => mockGameDao.insertGames(mockGameEntities)).called(1);
      verifyNoMoreInteractions(mockGameDao);
    });

    test('should return cached games from the database', () async {
      // Arrange
      when(() => mockGameDao.getAllGames()).thenAnswer((_) async => mockGameEntities);

      // Act
      final result = await localDataSource.getCachedGames();

      // Assert
      expect(result, equals(mockGameEntities));
      verify(() => mockGameDao.getAllGames()).called(1);
      verifyNoMoreInteractions(mockGameDao);
    });

    test('should return an empty list if no games are cached', () async {
      // Arrange
      when(() => mockGameDao.getAllGames()).thenAnswer((_) async => []);

      // Act
      final result = await localDataSource.getCachedGames();

      // Assert
      expect(result, isEmpty);
      verify(() => mockGameDao.getAllGames()).called(1);
    });
  });
}
