import 'package:flutter/material.dart';

import '../../../core/services/location_service.dart';

class DashboardProvider
    extends ChangeNotifier {

  final LocationService _locationService =
  LocationService();

  String address = '';

  bool isLoading = false;

  Future<void> getLocation() async {

    isLoading = true;

    notifyListeners();

    address =
    await _locationService.getAddress();

    isLoading = false;

    notifyListeners();
  }
}