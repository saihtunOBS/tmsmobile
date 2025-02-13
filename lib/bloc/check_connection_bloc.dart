import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectionBloc {
  final _controller = StreamController<ConnectivityResult>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  CheckConnectionBloc() {
    _initConnectivity();
  }

  Stream<ConnectivityResult> get connectionStream => _controller.stream;

  Future<void> _initConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    if (result.isNotEmpty) {
      _controller.sink.add(result.first);
    }

    _startMonitoring();
  }

  void _startMonitoring() {
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      if (results.isNotEmpty) {
        _controller.sink
            .add(results.first); // Take the first connectivity result
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }
}
