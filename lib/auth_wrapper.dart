import 'package:ecommerceapp/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/product/screens/product_screen.dart';


class AuthWrapper extends StatelessWidget {

  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user =
        FirebaseAuth.instance.currentUser;

    if (user != null) {

      return const MainScreen();

    } else {

      return const LoginScreen();
    }
  }
}