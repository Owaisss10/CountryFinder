import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

final _log = Logger('NetworkMonitor');

abstract interface class NetworkMonitor {
  /// `true` until the first connectivity event arrives.
  bool get isConnected;
}

class ConnectivityNetworkMonitor implements NetworkMonitor {
  ConnectivityNetworkMonitor([Connectivity? connectivity])
    : _connectivity = connectivity ?? Connectivity() {
    _subscription = _connectivity.onConnectivityChanged.listen(
      _update,
      onError: (Object e) => _log.warning('Connectivity stream error', e),
    );
    unawaited(_checkNow());
  }

  /// The stream only reports changes, so read the current state once.
  Future<void> _checkNow() async {
    try {
      _update(await _connectivity.checkConnectivity());
    } on Object catch (e) {
      _log.warning('Connectivity check failed', e);
    }
  }

  final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  bool _isConnected = true;

  @override
  bool get isConnected => _isConnected;

  void _update(List<ConnectivityResult> results) {
    _isConnected = results.any((r) => r != ConnectivityResult.none);
  }

  Future<void> dispose() => _subscription.cancel();
}
