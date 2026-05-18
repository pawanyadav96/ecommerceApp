import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/network_provider.dart';

class NetworkWrapper extends StatelessWidget {
  final Widget child;

  const NetworkWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, provider, _) {
        return Stack(
          children: [
            child,

            // no internet banner
            if (!provider.isConnected)
              Positioned(
                top: 0,
                left: 0,
                right: 0,

                child: Material(
                  color: Colors.red,

                  child: SafeArea(
                    bottom: false,

                    child: Container(
                      padding: const EdgeInsets.all(12),

                      alignment: Alignment.center,

                      child: const Text(
                        "No Internet Connection",

                        style: TextStyle(
                          color: Colors.white,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
