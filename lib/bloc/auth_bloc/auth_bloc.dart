import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/bloc/auth_bloc/auth_event.dart';
import 'package:send_money/bloc/auth_bloc/auth_state.dart';
import 'package:send_money/data/repository/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepo authRepo;
  AuthBloc({required this.authRepo}) : super(AuthInitialState()) {
    on<AuthLoginEvent>(_onUserAuthenticate);
  }

  Future<void> _onUserAuthenticate(
      AuthLoginEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoadingState());
    try {
      final isUserAuthenticated = await authRepo.userAuthenticate(event.requestData);

      emit(AuthLoginSuccessState(isUserLoggedIn: isUserAuthenticated));
    } catch (_) {
      emit(AuthErrorState());
    }
  }
}