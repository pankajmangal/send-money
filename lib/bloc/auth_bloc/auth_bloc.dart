import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/bloc/auth_bloc/auth_event.dart';
import 'package:send_money/bloc/auth_bloc/auth_state.dart';
import 'package:send_money/data/network/local/secure_storage_service.dart';
import 'package:send_money/data/network/remote/api_result.dart';
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
      final Result result = await authRepo.userAuthenticate(event.requestData);

      if(result.isSuccess){
        SecureStorageService storageService = SecureStorageService();
        storageService.saveAccessToken((result.successResponse as Map<String, dynamic>)["token"]);
        emit(const AuthLoginSuccessState(isUserLoggedIn: true));
      }else{
        emit(AuthErrorState(errMessage: result.failure?.statusMessage ?? ""));
      }
    } catch (_) {
      emit(const AuthErrorState(errMessage: "Something went wrong!"));
    }
  }
}