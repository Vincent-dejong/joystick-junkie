import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joystick_junkie/core/constants/jj_colors.dart';
import 'package:joystick_junkie/core/services/connectivity_service.dart';
import 'package:joystick_junkie/presentation/atoms/jj_loader.dart';
import 'package:joystick_junkie/presentation/bloc/game/game_bloc.dart';
import 'package:joystick_junkie/presentation/templates/games_list_template.dart';
import 'package:joystick_junkie/service_provider.dart';

class GamesListScreen extends StatefulWidget {
  const GamesListScreen({super.key});

  @override
  State<GamesListScreen> createState() => _GamesListScreenState();
}

class _GamesListScreenState extends State<GamesListScreen> {
  late final ConnectivityService _connectivityService;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _connectivityService = getIt<ConnectivityService>();

    // Listen to connectivity changes
    _connectivityService.connectionStatusStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });

    // Check initial connectivity status
    _connectivityService.getCurrentStatus().then((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GameBloc>()..add(const FetchGamesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            spacing: 8.0,
            mainAxisSize: MainAxisSize.min,
            children: [
              JJLoader(size: 50),
              Column(
                spacing: 4,
                children: [
                  Text('Joystick'),
                  Text('Junkie'),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            if (!_isConnected)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: JJColors.error,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'You are offline. We are displaying cached data.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            const Expanded(
              child: GamesListTemplate(),
            ),
          ],
        ),
      ),
    );
  }
}
