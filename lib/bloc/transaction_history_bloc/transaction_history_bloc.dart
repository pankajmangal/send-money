import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_event.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_state.dart';
import 'package:send_money/data/repository/transaction_history_repo.dart';

class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState>{

  final TransactionHistoryRepo transactionHistoryRepo;
  TransactionHistoryBloc({required this.transactionHistoryRepo}) : super(TransactionInitialState()) {
    on<FetchTransactionDataFromServerEvent>(_onFetchTransactionData);
  }

  Future<void> _onFetchTransactionData(
      TransactionHistoryEvent event,
      Emitter<TransactionHistoryState> emit,
      ) async {
    debugPrint("_onFetchTransactionData");
    // emit(TransactionLoadingState());
    try {
      final transactionData = await transactionHistoryRepo.getTransactionData();

      emit(TransactionSuccessState(data: transactionData));
    } catch (_) {
      emit(TransactionFailureState());
    }
  }
}