import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkProvider extends ChangeNotifier {
  bool isConnected = true;

  late StreamSubscription<List<ConnectivityResult>> subscription;

  NetworkProvider() {
    checkInitialConnection();

    listenInternet();
  }

  // Internet check
  Future<void> checkInitialConnection() async {
    final result = await Connectivity().checkConnectivity();

    isConnected = !result.contains(ConnectivityResult.none);

    notifyListeners();
  }

  void listenInternet() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      isConnected = !result.contains(ConnectivityResult.none);

      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }
}
