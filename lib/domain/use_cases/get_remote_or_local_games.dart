import 'package:joystick_junkie/domain/models/game.dart';
import 'package:joystick_junkie/domain/repositories/game_repository.dart';

final class GetRemoteOrLocalGames {
  final GameRepository _gameRepository;

  GetRemoteOrLocalGames(this._gameRepository);

  Future<List<Game>> call({
    int page = 1,
    int pageSize = 20,
  }) async {
    return await _gameRepository.getGames(
      page: page,
      pageSize: pageSize,
    );
  }
}
