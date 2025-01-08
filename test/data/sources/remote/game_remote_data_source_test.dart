import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joystick_junkie/core/constants/api_constants.dart';
import 'package:joystick_junkie/data/entities/game_entity.dart';
import 'package:joystick_junkie/data/sources/remote/game_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockDio mockDio;
  late GameRemoteDataSource remoteDataSource;

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = GameRemoteDataSource(dio: mockDio);
  });

  group('fetchGames', () {
    const mockResponseData = [
      {
        'id': 1,
        'name': 'Test Game 1',
        'cover': {'url': 'url1'},
        'summary': 'Description 1',
        'rating': 4.5,
      },
      {
        'id': 2,
        'name': 'Test Game 2',
        'cover': {'url': 'url2'},
        'summary': 'Description 2',
        'rating': 3.5,
      },
    ];

    final mockGames = mockResponseData.map((json) => GameEntity.fromJson(json)).toList();

    test('should fetch a list of games and parse them correctly', () async {
      // Arrange
      const page = 1;
      const pageSize = 5;
      const offset = (page - 1) * pageSize;

      when(() => mockDio.post(
            '${ApiConstants.baseUrl}${ApiConstants.gamesEndpoint}',
            data: any(named: 'data'),
          )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockResponseData,
            statusCode: 200,
          ));

      // Act
      final result = await remoteDataSource.fetchGames(page: page, pageSize: pageSize);

      // Assert
      expect(result, equals(mockGames));
      verify(() => mockDio.post(
            '${ApiConstants.baseUrl}${ApiConstants.gamesEndpoint}',
            data:
                '''f id, name, cover.url, summary, rating, storyline, first_release_date; s rating desc; limit $pageSize; offset $offset;''',
          )).called(1);
    });

    test('should throw an exception on network error', () async {
      // Arrange
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenThrow(DioError(
        requestOptions: RequestOptions(path: ''),
        error: 'Network Error',
      ));

      // Act
      final call = remoteDataSource.fetchGames;

      // Assert
      expect(() => call(page: 1, pageSize: 5), throwsA(isA<DioError>()));
      verify(() => mockDio.post(any(), data: any(named: 'data'))).called(1);
    });
  });
}
