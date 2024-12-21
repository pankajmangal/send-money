import 'package:equatable/equatable.dart';

abstract class HomeToggleEvent extends Equatable{
  const HomeToggleEvent();

  @override
  List<Object?> get props => [];
}

class ToggleONEvent extends HomeToggleEvent {}

class ToggleOFFEvent extends HomeToggleEvent {}