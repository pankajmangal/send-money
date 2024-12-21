import 'package:equatable/equatable.dart';

abstract class HomeToggleState extends Equatable {
  const HomeToggleState();

  @override
  List<Object?> get props => [];
}

class ToggleChangeState extends HomeToggleState {
  final bool isSwitchChanged;

  const ToggleChangeState({required this.isSwitchChanged});

  @override
  List<Object> get props => [isSwitchChanged];
}