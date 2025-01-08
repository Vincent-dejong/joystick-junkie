import 'dart:async';

import 'package:floor/floor.dart';
import 'package:joystick_junkie/data/entities/game_entity.dart';
import 'package:joystick_junkie/data/sources/local/databases/game_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [GameEntity])
abstract class AppDatabase extends FloorDatabase {
  GameDao get gameDao;
}
