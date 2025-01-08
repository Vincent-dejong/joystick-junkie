part of 'game_bloc.dart';

@immutable
sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

class GamesLoadingState extends GameState {
  final List<Game> games;
  const GamesLoadingState({
    this.games = const [],
  });
}

class GameNextPageLoadingState extends GameState {
  const GameNextPageLoadingState();
}

class GameLoadedState extends GameState {
  final List<Game> games;

  const GameLoadedState({
    required this.games,
  });

  @override
  List<Object?> get props => [games];
}

class GameErrorState extends GameState {
  final String message;

  const GameErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
