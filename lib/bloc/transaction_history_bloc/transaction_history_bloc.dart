import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/data/models/response/transaction_history_data.dart';
import 'package:send_money/data/network/remote/api_result.dart';
import 'package:send_money/data/repository/transaction_repo.dart';
import 'package:send_money/utils/DatabaseUtils.dart';
import 'package:equatable/equatable.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  final TransactionRepo transactionRepo;

  TransactionHistoryBloc({required this.transactionRepo})
      : super(TransactionHistoryInitialState()) {

    on<FetchAllTransactionFromServerEvent>(_onFetchAllTransaction);

    on<FetchAllTransactionFromLocalEvent>(_onFetchAllTransactionFromStorage);
  }

  Future<void> _onFetchAllTransaction(
      FetchAllTransactionFromServerEvent event,
    Emitter<TransactionHistoryState> emit,
  ) async {
    emit((TransactionHistoryLoadingState()));
    try {
      final Result result = await transactionRepo.fetchAllTransactions();

      if (result.isSuccess) {
        var transactionHistoryData =
            result.successResponse as TransactionHistoryData;
        // Clear the existing data in the database before saving the new list
        await DatabaseUtils().clearDatabase();
        DatabaseUtils().insertTransactionList(transactionHistoryData.data);
        emit(TransactionHistorySuccessState(historyData: transactionHistoryData.data));
      } else {
        emit(TransactionHistoryErrorState(
            errMessage: result.failure?.statusMessage ?? ""));
      }
    } catch (_) {
      emit(const TransactionHistoryErrorState(errMessage: "Something went wrong!"));
    }
  }

  Future<void> _onFetchAllTransactionFromStorage(
    FetchAllTransactionFromLocalEvent event,
    Emitter<TransactionHistoryState> emit,
  ) async {
    emit((TransactionHistoryLoadingState()));
    try {
      List<TransactionData> transactionHistoryData =
          await DatabaseUtils().getTransactionMapList();
      debugPrint("InsertedRowCount => ${transactionHistoryData.length}");
      emit(TransactionHistorySuccessState(historyData: transactionHistoryData));
    } catch (_) {
      emit(const TransactionHistoryErrorState(errMessage: "Something went wrong!"));
    }
  }
}