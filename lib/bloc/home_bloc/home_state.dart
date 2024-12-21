import 'package:equatable/equatable.dart';
import 'package:send_money/data/models/response/user_data.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeInitialState extends HomeState {
  final bool isSwitchChanged;

  const HomeInitialState({required this.isSwitchChanged});

  @override
  List<Object> get props => [isSwitchChanged];
}

class HomeSuccessState extends HomeState{
  final UserData userData;

  const HomeSuccessState({required this.userData});

  @override
  List<Object> get props => [userData];
}

class HomeUserLogoutState extends HomeState {}

class HomeErrorState extends HomeState{
  final String errMessage;

  const HomeErrorState({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}