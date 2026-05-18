import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../main_screen.dart';
import '../provider/auth_provider.dart';


import '../../dashboard/screens/dashboard_screen.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {

            return Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                Image.asset(
                  "assets/google.png",
                  height: 120,
                  width: 120,
                ),

                const SizedBox(height: 40),

                const Text(
                  "Hello,User",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                CustomButton(
                  title:
                  "Login With Google",

                  isLoading:
                  provider.isLoading,

                  onTap: () async {

                    await provider.login();

                    // If successful login
                    if (provider.user != null) {

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const  MainScreen(),
                        ),
                      );
                    }
                    if (provider.error
                        .isNotEmpty) {

                      ScaffoldMessenger.of(
                          context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            provider.error,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}