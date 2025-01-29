// lib/login/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_cubit.dart';
import '../login/login_state.dart';
import 'dashboard_screen.dart'; // Import the Dashboard screen
import '../repositories/authentication_repository.dart'; // Ensure we have the repo

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Login'),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            // Once login is successful, navigate to Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => DashboardScreen(authRepository: authRepository),
              ),
            );
          } else if (state.status == LoginStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Login Failed')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == LoginStatus.submitting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) =>
                      context.read<LoginCubit>().emailChanged(value),
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) =>
                      context.read<LoginCubit>().passwordChanged(value),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginCubit>().logInWithCredentials();
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
