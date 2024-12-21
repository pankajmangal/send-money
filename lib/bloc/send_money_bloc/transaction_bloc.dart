import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/bloc/send_money_bloc/transaction_event.dart';
import 'package:send_money/bloc/send_money_bloc/transaction_state.dart';
import 'package:send_money/data/network/local/secure_storage_service.dart';
import 'package:send_money/data/network/remote/api_result.dart';
import 'package:send_money/data/repository/transaction_repo.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {

  final TransactionRepo transactionRepo;
  TransactionBloc({required this.transactionRepo}) : super(TransactionInitialState()) {
    on<CreateTransactionEvent>(_onCreateTransaction);
  }

  Future<void> _onCreateTransaction(
      CreateTransactionEvent event,
      Emitter<TransactionState> emit,
      ) async {
    emit((TransactionLoadingState()));
    try {
      final Result result = await transactionRepo.createTransaction(event.requestData);

      if(result.isSuccess){
        SecureStorageService storageService = SecureStorageService();
        storageService.saveAccessToken((result.successResponse as Map<String, dynamic>)["token"]);
        emit(const TransactionSuccessState(successMsg: ""));
      }else{
        emit(TransactionErrorState(errMessage: result.failure?.statusMessage ?? ""));
      }
    } catch (_) {
      emit(const TransactionErrorState(errMessage: "Something went wrong!"));
    }
  }
}