import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeUserProfileEvent extends HomeEvent {}

class HomeUserLogoutEvent extends HomeEvent {}