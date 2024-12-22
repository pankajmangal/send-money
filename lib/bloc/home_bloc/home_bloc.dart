import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_event.dart';
import 'package:send_money/bloc/home_bloc/home_state.dart';
import 'package:send_money/data/models/response/user_data.dart';
import 'package:send_money/data/network/remote/api_result.dart';
import 'package:send_money/data/repository/auth_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final AuthRepo authRepo;

  HomeBloc({required this.authRepo}) : super(const HomeInitialState(isSwitchChanged: true)){

    on<HomeUserProfileEvent>(_onFetchUserProfile);

    on<HomeUserLogoutEvent>((event, emit) {
      emit(HomeUserLogoutState());
    });
  }

  Future<void> _onFetchUserProfile(
      HomeEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final Result result = await authRepo.fetchUserDetails();

      if(result.isSuccess){
        String name = (result.successResponse as Map<String, dynamic>)["name"];
        String amount = (result.successResponse as Map<String, dynamic>)["balance"];
        emit(HomeSuccessState(userData: UserData(name: name, email: "", amount: amount)));
      }else{
        emit(HomeErrorState(errMessage: result.failure?.statusMessage ?? ""));
      }
    } catch (_) {
      emit(const HomeErrorState(errMessage: "Something went wrong!"));
    }
  }
}