import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/features/auth/data/datasources/auth_service.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService authService;

  RegisterBloc(this.authService) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        final success = await authService.register(event.dto);

        if (success) {
          emit(RegisterSuccess());
        } else {
          emit(RegisterError('Registration failed'));
        }
      } catch (_) {
        emit(RegisterError('Something went wrong'));
      }
    });
  }
}
