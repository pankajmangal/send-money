import 'package:equatable/equatable.dart';
import 'package:send_money/data/models/user_authenticate_request_data.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final UserAuthenticateRequestData requestData;

  const AuthLoginEvent({required this.requestData});

  @override
  List<Object?> get props => [requestData];
}

class AuthLogoutEvent extends AuthEvent {}