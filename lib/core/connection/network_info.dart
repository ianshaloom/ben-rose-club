import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class NetworkInfo {
  /// singleton instance of NetworkInfoImpl
  static final NetworkInfo _instance = NetworkInfo._internal(Connectivity());

  /// factory constructor to return the singleton instance
  factory NetworkInfo() {
    return _instance;
  }

  /// private constructor
  NetworkInfo._internal(this._connectivity);

  final Connectivity _connectivity;

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result.any((element) => element == ConnectivityResult.none)) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  Stream<ConnectivityResult> get onStatusChange =>
      _connectivity.onConnectivityChanged.map((result) {
        if (result.any((element) => element != ConnectivityResult.none)) {
          return result.first;
        } else {
          return ConnectivityResult.none;
        }
      });
}
