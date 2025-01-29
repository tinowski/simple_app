// lib/login/login_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'login_state.dart';
import '../repositories/authentication_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginState());

  // Update email in state
  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  // Update password in state
  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  // Attempt login
  Future<void> logInWithCredentials() async {
    // Indicate we are submitting
    emit(state.copyWith(status: LoginStatus.submitting));

    try {
      await _authRepository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      // If success, update status
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      // If error, update status and possibly store the error message
      emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
