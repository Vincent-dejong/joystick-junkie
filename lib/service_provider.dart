import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:joystick_junkie/core/constants/api_constants.dart';
import 'package:joystick_junkie/core/helpers/network_info.dart';
import 'package:joystick_junkie/data/sources/local/databases/app_database.dart';
import 'package:joystick_junkie/data/sources/local/game_local_data_source.dart';
import 'package:joystick_junkie/data/sources/remote/game_remote_data_source.dart';
import 'package:joystick_junkie/domain/repositories/game_repository.dart';
import 'package:joystick_junkie/domain/use_cases/get_remote_or_local_games.dart';
import 'package:joystick_junkie/presentation/bloc/game/game_bloc.dart';

import 'core/services/connectivity_service.dart';

final GetIt getIt = GetIt.instance;

class ServiceProvider {
  static Future<void> registerDependencies() async {
    // Register Dio
    getIt.registerSingleton<Dio>(
      Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          headers: {
            "Client-ID": ApiConstants.clientId,
            "Authorization": "Bearer ${ApiConstants.bearerToken}",
          },
        ),
      ),
    );

    // Helpers
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfo());

    // Services
    getIt.registerSingleton<ConnectivityService>(ConnectivityService());

    // Database
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    getIt.registerSingleton<AppDatabase>(database);

    // Local data sources
    getIt.registerSingleton<GameLocalDataSource>(
        GameLocalDataSource(database: getIt<AppDatabase>()));

    // Remote data sources
    getIt.registerSingleton<GameRemoteDataSource>(GameRemoteDataSource(dio: getIt<Dio>()));

    // Repositories
    getIt.registerSingleton<GameRepository>(
      GameRepository(
        remoteDataSource: getIt<GameRemoteDataSource>(),
        localDataSource: getIt<GameLocalDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    );

    // Use cases
    getIt.registerSingleton<GetRemoteOrLocalGames>(
      GetRemoteOrLocalGames(getIt<GameRepository>()),
    );

    // Blocs
    getIt.registerFactory<GameBloc>(
      () => GameBloc(getRemoteOrLocalGames: getIt<GetRemoteOrLocalGames>()),
    );
  }
}
