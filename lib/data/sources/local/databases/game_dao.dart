import 'package:floor/floor.dart';
import 'package:joystick_junkie/data/entities/game_entity.dart';

@dao
abstract class GameDao {
  @Query('SELECT * FROM games')
  Future<List<GameEntity>> getAllGames();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGames(List<GameEntity> games);
}
