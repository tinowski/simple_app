// lib/dashboard_screen.dart

import 'package:flutter/material.dart';
import '../repositories/authentication_repository.dart';

class DashboardScreen extends StatelessWidget {
  final AuthenticationRepository authRepository;

  const DashboardScreen({Key? key, required this.authRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Just a simple screen showing "Dashboard"
    // and a sign-out button.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Dashboard!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),

            // Optional: Sign Out button
            ElevatedButton(
              onPressed: () async {
                await authRepository.signOut();
                // After signing out, go back to LoginScreen
                // or push a route that leads to login again
                Navigator.of(context).pop();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
