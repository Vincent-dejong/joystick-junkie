import 'package:joystick_junkie/core/helpers/network_info.dart';
import 'package:joystick_junkie/data/sources/local/game_local_data_source.dart';
import 'package:joystick_junkie/data/sources/remote/game_remote_data_source.dart';
import 'package:joystick_junkie/domain/models/game.dart';

class GameRepository {
  final GameRemoteDataSource _remoteDataSource;
  final GameLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  GameRepository({
    required GameRemoteDataSource remoteDataSource,
    required GameLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  Future<List<Game>> getGames({
    int page = 1,
    int pageSize = 20,
  }) async {
    final isOnline = await _networkInfo.isConnected();

    if (isOnline) {
      final remoteGames = await _remoteDataSource.fetchGames(
        page: page,
        pageSize: pageSize,
      );

      await _localDataSource.saveGameEntities(remoteGames);

      return remoteGames.map((entity) => Game.fromEntity(entity)).toList();
    } else {
      final entities = await _localDataSource.getCachedGames();

      return entities.map((entity) => Game.fromEntity(entity)).toList();
    }
  }
}
