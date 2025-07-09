import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/features/auth/data/datasources/auth_service.dart';
import 'package:tukuntech/features/auth/data/models/login_dto.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        final success = await authService.login(
          LoginDTO(username: event.username, password: event.password),
        );
        if (success) {
          emit(AuthSuccess());
        } else {
          emit(AuthFailure('Login incorrecto'));
        }
      } catch (e) {
        emit(AuthFailure('Error de red'));
      }
    });
  }
}