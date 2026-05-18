import 'package:ecommerceapp/features/auth/provider/auth_provider.dart';
import 'package:ecommerceapp/features/auth/screens/login_screen.dart';
import 'package:ecommerceapp/features/dashboard/provider/dashboard_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DashboardProvider>().getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),

        actions: [
          IconButton(
            onPressed: () async {
              await context.read<AuthProvider>().logout();

              Navigator.pushAndRemoveUntil(
                context,

                MaterialPageRoute(builder: (_) => const LoginScreen()),

                (route) => false,
              );
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Consumer<DashboardProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // PROFILE IMAGE
                  CircleAvatar(
                    radius: 50,

                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,

                    child: user?.photoURL == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),

                  const SizedBox(height: 20),

                  // NAME
                  Text(
                    user?.displayName ?? "No Name",

                    style: const TextStyle(
                      fontSize: 24,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // EMAIL
                  Text(
                    user?.email ?? "No Email",

                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 40),

                  // LOCATION CARD
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,

                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Row(
                          children: [
                            Icon(Icons.location_on),

                            SizedBox(width: 8),

                            Text(
                              "Current Location",

                              style: TextStyle(
                                fontSize: 20,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // LOADING
                        if (provider.isLoading)
                          const Center(child: CircularProgressIndicator())
                        // GPS disabled
                        else if (provider.address == "GPS is Disabled")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const Text(
                                "GPS is Disabled",

                                style: TextStyle(
                                  fontSize: 16,

                                  color: Colors.red,
                                ),
                              ),

                              const SizedBox(height: 10),

                              ElevatedButton(
                                onPressed: () {
                                  Geolocator.openLocationSettings();
                                },

                                child: const Text("Open GPS Settings"),
                              ),
                            ],
                          )
                        // permission denied
                        else if (provider.address ==
                            "Location Permission Denied")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const Text(
                                "Location Permission Denied",

                                style: TextStyle(
                                  fontSize: 16,

                                  color: Colors.red,
                                ),
                              ),

                              const SizedBox(height: 10),

                              ElevatedButton(
                                onPressed: () {
                                  provider.getLocation();
                                },

                                child: const Text("Allow Permission"),
                              ),
                            ],
                          )
                        // permission permantely denied
                        else if (provider.address ==
                            "Permission Permanently Denied")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const Text(
                                "Permission Permanently Denied",

                                style: TextStyle(
                                  fontSize: 16,

                                  color: Colors.red,
                                ),
                              ),

                              const SizedBox(height: 10),

                              ElevatedButton(
                                onPressed: () {
                                  Geolocator.openAppSettings();
                                },

                                child: const Text("Open App Settings"),
                              ),
                            ],
                          )
                        // SUCCESS
                        else
                          Text(
                            provider.address,

                            style: const TextStyle(fontSize: 16),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
