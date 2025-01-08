import 'package:flutter_test/flutter_test.dart';
import 'package:joystick_junkie/domain/models/game.dart';
import 'package:joystick_junkie/domain/repositories/game_repository.dart';
import 'package:joystick_junkie/domain/use_cases/get_remote_or_local_games.dart';
import 'package:mocktail/mocktail.dart';

class MockGameRepository extends Mock implements GameRepository {}

void main() {
  late MockGameRepository mockGameRepository;
  late GetRemoteOrLocalGames getRemoteOrLocalGames;

  setUp(() {
    mockGameRepository = MockGameRepository();
    getRemoteOrLocalGames = GetRemoteOrLocalGames(mockGameRepository);
  });

  group('GetRemoteOrLocalGames', () {
    final mockGames = [
      const Game(id: 1, name: 'Game 1', summary: 'Description 1', coverImageUrl: 'url1'),
      const Game(id: 2, name: 'Game 2', summary: 'Description 2', coverImageUrl: 'url2'),
    ];

    test('should return a list of games when repository call is successful', () async {
      // Arrange
      when(() => mockGameRepository.getGames(page: 1, pageSize: 20))
          .thenAnswer((_) async => mockGames);

      // Act
      final result = await getRemoteOrLocalGames(page: 1, pageSize: 20);

      // Assert
      expect(result, equals(mockGames));
      verify(() => mockGameRepository.getGames(page: 1, pageSize: 20)).called(1);
      verifyNoMoreInteractions(mockGameRepository);
    });

    test('should throw an exception when repository call fails', () async {
      // Arrange
      when(() => mockGameRepository.getGames(page: 1, pageSize: 20))
          .thenThrow(Exception('Failed to fetch games'));

      // Act
      final call = getRemoteOrLocalGames.call;

      // Assert
      expect(
        () async => await call(page: 1, pageSize: 20),
        throwsA(isA<Exception>()),
      );
      verify(() => mockGameRepository.getGames(page: 1, pageSize: 20)).called(1);
      verifyNoMoreInteractions(mockGameRepository);
    });

    test('should use default parameters if none are provided', () async {
      // Arrange
      when(() => mockGameRepository.getGames(page: 1, pageSize: 20))
          .thenAnswer((_) async => mockGames);

      // Act
      final result = await getRemoteOrLocalGames();

      // Assert
      expect(result, equals(mockGames));
      verify(() => mockGameRepository.getGames(page: 1, pageSize: 20)).called(1);
    });
  });
}
