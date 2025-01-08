import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joystick_junkie/domain/models/game.dart';
import 'package:joystick_junkie/domain/use_cases/get_remote_or_local_games.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GetRemoteOrLocalGames _getRemoteOrLocalGames;

  List<Game> _games = [];
  int _currentPage = 0;
  final int _pageSize = 20;

  GameBloc({
    required GetRemoteOrLocalGames getRemoteOrLocalGames,
  })  : _getRemoteOrLocalGames = getRemoteOrLocalGames,
        super(const GamesLoadingState()) {
    on<FetchGamesEvent>(_onFetchGames);
  }

  Future<void> _onFetchGames(FetchGamesEvent event, Emitter<GameState> emit) async {
    try {
      // If it's loading more games, keep the current list, else reset
      if (!event.isLoadMore) {
        emit(const GamesLoadingState());
        _currentPage = 0; // Reset to first page when loading new games
        _games = await _getRemoteOrLocalGames(page: _currentPage, pageSize: _pageSize);
      } else {
        emit(GamesLoadingState(games: _games)); // Show loading with existing games
        _currentPage++;
        final newGames = await _getRemoteOrLocalGames(
          page: _currentPage,
          pageSize: _pageSize,
        );

        for (final game in newGames) {
          if (!_games.any((g) => g.id == game.id)) {
            _games.add(game);
          }
        }
      }

      emit(GameLoadedState(games: _games));
    } catch (e) {
      emit(GameErrorState(message: e.toString()));
    }
  }
}
