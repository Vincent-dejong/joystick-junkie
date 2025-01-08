import 'package:flutter_test/flutter_test.dart';
import 'package:joystick_junkie/data/entities/game_entity.dart';
import 'package:joystick_junkie/domain/models/game.dart';
import 'package:joystick_junkie/domain/repositories/game_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late GameRepository repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = GameRepository(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getGames', () {
    final mockGameEntities = [
      const GameEntity(id: 1, name: 'Game 1', summary: 'Description 1', coverImageUrl: 'url1'),
      const GameEntity(id: 2, name: 'Game 2', summary: 'Description 2', coverImageUrl: 'url2'),
    ];

    final mockGames = mockGameEntities.map((entity) => Game.fromEntity(entity)).toList();

    test('should fetch games from remote source when online', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.fetchGames(page: 1, pageSize: 20))
          .thenAnswer((_) async => mockGameEntities);
      when(() => mockLocalDataSource.saveGameEntities(any())).thenAnswer((_) async {});

      // Act
      final result = await repository.getGames(page: 1, pageSize: 20);

      // Assert
      expect(result, equals(mockGames));
      verify(() => mockNetworkInfo.isConnected()).called(1);
      verify(() => mockRemoteDataSource.fetchGames(page: 1, pageSize: 20)).called(1);
      verify(() => mockLocalDataSource.saveGameEntities(mockGameEntities)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should fetch games from local source when offline', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => false);
      when(() => mockLocalDataSource.getCachedGames()).thenAnswer((_) async => mockGameEntities);

      // Act
      final result = await repository.getGames(page: 1, pageSize: 20);

      // Assert
      expect(result, equals(mockGames));
      verify(() => mockNetworkInfo.isConnected()).called(1);
      verify(() => mockLocalDataSource.getCachedGames()).called(1);
      verifyNever(() => mockRemoteDataSource.fetchGames(
          page: any(named: 'page'), pageSize: any(named: 'pageSize')));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should throw an exception when remote fetch fails while online', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.fetchGames(page: 1, pageSize: 20))
          .thenThrow(Exception('Remote fetch failed'));

      // Act
      final call = repository.getGames;

      // Assert
      expect(() => call(page: 1, pageSize: 20), throwsA(isA<Exception>()));
      verify(() => mockNetworkInfo.isConnected()).called(1);
    });

    test('should return an empty list when local cache is empty and offline', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => false);
      when(() => mockLocalDataSource.getCachedGames()).thenAnswer((_) async => []);

      // Act
      final result = await repository.getGames(page: 1, pageSize: 20);

      // Assert
      expect(result, isEmpty);
      verify(() => mockNetworkInfo.isConnected()).called(1);
      verify(() => mockLocalDataSource.getCachedGames()).called(1);
      verifyNever(() => mockRemoteDataSource.fetchGames(
          page: any(named: 'page'), pageSize: any(named: 'pageSize')));
    });
  });
}
