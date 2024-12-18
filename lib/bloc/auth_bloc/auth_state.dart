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

  AuthLoginSuccessState({required this.isUserLoggedIn});

  @override
  List<Object> get props => [isUserLoggedIn];
}

class AuthErrorState extends AuthState{}

class AuthLogoutSuccessState extends AuthState{}