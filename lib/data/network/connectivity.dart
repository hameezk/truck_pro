import 'dart:io';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatusListener {
  static final _singleton = ConnectionStatusListener._internal();

  ConnectionStatusListener._internal();
  static ConnectionStatusListener getInstance() => _singleton;
  bool hasConnection = true;
  StreamController connectionChangeController = StreamController.broadcast();
  Stream get connectionChange => connectionChangeController.stream;

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    return hasConnection;
  }

  void dispose() {
    connectionChangeController.close();
  }

  final Connectivity _connectivity = Connectivity();

  void _connectionChange(List<ConnectivityResult> result) {
    checkConnection();
  }

  Future<void> initialize() async {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    await checkConnection();
  }
}
