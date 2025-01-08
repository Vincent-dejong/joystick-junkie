import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joystick_junkie/domain/models/game.dart';
import 'package:joystick_junkie/presentation/bloc/game/game_bloc.dart';
import 'package:joystick_junkie/presentation/molecules/game_list_tile.dart';

class GameListView extends StatefulWidget {
  final List<Game> games;
  final bool loadingMore;

  const GameListView({
    super.key,
    required this.games,
    this.loadingMore = false,
  });

  @override
  State<GameListView> createState() => _GameListViewState();
}

class _GameListViewState extends State<GameListView> {
  late ScrollController _scrollController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();

      // Debounce the load more event to prevent multiple calls
      _debounce = Timer(const Duration(milliseconds: 500), () {
        context.read<GameBloc>().add(const FetchGamesEvent(isLoadMore: true));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.games.length + (widget.loadingMore ? 1 : 0);

    return ListView.builder(
      controller: _scrollController,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // If we are loading more games, show a loading indicator at the end of the list, which is the same as the length of the games list
        if (index == widget.games.length) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        final game = widget.games[index];
        return GameListTile(game: game);
      },
    );
  }
}
