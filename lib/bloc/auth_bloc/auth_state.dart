import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthLoginSuccessState extends AuthState{
  final bool isUserLoggedIn;

  const AuthLoginSuccessState({required this.isUserLoggedIn});

  @override
  List<Object> get props => [isUserLoggedIn];
}

class AuthErrorState extends AuthState{
  final String errMessage;

  const AuthErrorState({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class AuthLogoutSuccessState extends AuthState{}