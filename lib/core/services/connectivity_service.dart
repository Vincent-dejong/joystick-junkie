import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionStatusController = StreamController<bool>.broadcast();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      for (final result in results) {
        _connectionStatusController.add(result != ConnectivityResult.none);
      }
    });
  }

  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  Future<bool> getCurrentStatus() async {
    final results = await _connectivity.checkConnectivity();

    final connectedStates = [
      ConnectivityResult.wifi,
      ConnectivityResult.ethernet,
      ConnectivityResult.mobile,
    ];

    for (var result in results) {
      if (connectedStates.contains(result)) {
        return true;
      }
    }

    return false;
  }

  void dispose() {
    _connectionStatusController.close();
  }
}
