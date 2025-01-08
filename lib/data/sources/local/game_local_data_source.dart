import 'package:joystick_junkie/data/entities/game_entity.dart';
import 'package:joystick_junkie/data/sources/local/databases/app_database.dart';

class GameLocalDataSource {
  final AppDatabase _database;

  GameLocalDataSource({required AppDatabase database}) : _database = database;

  Future<void> saveGameEntities(List<GameEntity> games) async {
    final dao = _database.gameDao;
    await dao.insertGames(games);
  }

  Future<List<GameEntity>> getCachedGames() async {
    final dao = _database.gameDao;
    return await dao.getAllGames();
  }
}
