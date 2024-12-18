import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}