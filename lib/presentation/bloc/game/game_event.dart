part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class FetchGamesEvent extends GameEvent {
  final bool isLoadMore;

  const FetchGamesEvent({this.isLoadMore = false});

  @override
  List<Object?> get props => [isLoadMore];
}
