import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_toggle_event.dart';
import 'package:send_money/bloc/home_bloc/home_toggle_state.dart';

class HomeToggleBloc extends Bloc<HomeToggleEvent, HomeToggleState> {

  HomeToggleBloc() : super(const ToggleChangeState(isSwitchChanged: true)){

    on<ToggleONEvent>((event, emit) {
      emit(const ToggleChangeState(isSwitchChanged: true));
    });

    on<ToggleOFFEvent>((event, emit) {
      emit(const ToggleChangeState(isSwitchChanged: false));
    });
  }
}