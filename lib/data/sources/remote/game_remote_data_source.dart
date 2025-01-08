import 'package:dio/dio.dart';
import 'package:joystick_junkie/core/constants/api_constants.dart';
import 'package:joystick_junkie/data/entities/game_entity.dart';

class GameRemoteDataSource {
  final Dio dio;

  GameRemoteDataSource({required this.dio});

  String _createUrl(String endpoint) => '${ApiConstants.baseUrl}$endpoint';

  /// Fetches a list of games from the IGDB API.
  Future<List<GameEntity>> fetchGames({
    int page = 1,
    int pageSize = 5,
  }) async {
    final offset = (page - 1) * pageSize;
    final data =
        '''f id, name, cover.url, summary, rating, storyline, first_release_date; s rating desc; limit $pageSize; offset $offset;''';
    try {
      final response = await dio.post(
        _createUrl(ApiConstants.gamesEndpoint),
        data: data,
      );

      final games = (response.data as List).map((game) => GameEntity.fromJson(game)).toList();

      return games;
    } catch (e) {
      rethrow;
    }
  }
}
