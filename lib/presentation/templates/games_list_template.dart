import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joystick_junkie/domain/models/game.dart';
import 'package:joystick_junkie/presentation/atoms/error_message.dart';
import 'package:joystick_junkie/presentation/atoms/jj_loader.dart';
import 'package:joystick_junkie/presentation/bloc/game/game_bloc.dart';
import 'package:joystick_junkie/presentation/organisms/games_list_view.dart';

class GamesListTemplate extends StatelessWidget {
  static const pageSize = 20;

  const GamesListTemplate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<GameBloc>(context).add(
          const FetchGamesEvent(),
        );
      },
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          switch (state) {
            case GameErrorState():
              return ErrorMessage(message: state.message);
            case GamesLoadingState():
              if (state.games.isEmpty) {
                return const JJLoader();
              }

              return _gamesList(state.games, loadingMore: true);
            case GameLoadedState():
              return _gamesList(state.games);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _gamesList(
    List<Game> games, {
    bool loadingMore = false,
  }) =>
      GameListView(
        games: games,
        loadingMore: loadingMore,
      );
}
