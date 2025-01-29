// lib/main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/authentication_repository.dart';
import 'login/login_cubit.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthenticationRepository();

    return RepositoryProvider.value(
      value: authRepository,
      child: MaterialApp(
        title: 'Simple Firebase Login',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: BlocProvider(
          create: (_) => LoginCubit(authRepository),
          child: const LoginScreen(),
        ),
      ),
    );
  }
}
