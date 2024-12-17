import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_event.dart';
import 'package:send_money/bloc/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(isSwitchChanged: true)){
    on<ToggleONEvent>((event, emit) {
      emit(const HomeState(isSwitchChanged: true));
    });

    on<ToggleOFFEvent>((event, emit) {
      emit(const HomeState(isSwitchChanged: false));
    });
  }
}