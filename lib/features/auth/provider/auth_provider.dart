import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {

  final AuthService _authService =
  AuthService();

  bool isLoading = false;

  User? user;

  String error = '';

  Future<void> login() async {

    try {

      isLoading = true;

      notifyListeners();

      user =
      await _authService
          .signInWithGoogle();

      error = '';

    } catch (e) {

      error = e.toString();
    }

    isLoading = false;

    notifyListeners();
  }

  Future<void> logout() async {

    await _authService.logout();

    user = null;

    notifyListeners();
  }
}