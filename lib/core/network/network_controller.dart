import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController {
  final StreamController<List<ConnectivityResult>> _connectionChangeStream =
      StreamController<List<ConnectivityResult>>();

  List<ConnectivityResult>? _currentResult;

  // Constructor to listen for initial connection status
  void initialiseNetworkMonitor() {
    Connectivity().onConnectivityChanged.listen((result) {
      _currentResult = result;
      _connectionChangeStream.add(result);
      if (result.contains(ConnectivityResult.none)) {
        print('No Internet');
      }
    });
  }

  List<ConnectivityResult>? get currentConnection => _currentResult;

  Stream<List<ConnectivityResult>> get connectionChanges =>
      _connectionChangeStream.stream;
}
