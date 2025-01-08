import 'package:dio/dio.dart';
import 'package:joystick_junkie/core/helpers/igdb_image_url_helper.dart';
import 'package:joystick_junkie/core/helpers/network_info.dart';
import 'package:joystick_junkie/data/sources/local/databases/app_database.dart';
import 'package:joystick_junkie/data/sources/local/databases/game_dao.dart';
import 'package:joystick_junkie/data/sources/local/game_local_data_source.dart';
import 'package:joystick_junkie/data/sources/remote/game_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements GameRemoteDataSource {}

class MockLocalDataSource extends Mock implements GameLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockIGDBImageUrlHelper extends Mock implements IGDBImageUrlHelper {}

class MockGameDao extends Mock implements GameDao {}

class MockDio extends Mock implements Dio {}
