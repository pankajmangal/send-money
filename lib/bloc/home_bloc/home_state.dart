import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isSwitchChanged;

  const HomeState({required this.isSwitchChanged});

  @override
  List<Object> get props => [isSwitchChanged];
}