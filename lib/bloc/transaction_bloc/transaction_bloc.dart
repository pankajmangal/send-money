import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/bloc/transaction_bloc/transaction_event.dart';
import 'package:send_money/bloc/transaction_bloc/transaction_state.dart';
import 'package:send_money/data/models/response/transaction_history_data.dart';
import 'package:send_money/data/network/remote/api_result.dart';
import 'package:send_money/data/repository/transaction_repo.dart';
import 'package:send_money/utils/DatabaseUtils.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepo transactionRepo;

  TransactionBloc({required this.transactionRepo})
      : super(TransactionInitialState()) {
    on<CreateTransactionEvent>(_onCreateTransaction);

    on<FetchAllTransactionEvent>(_onFetchAllTransaction);

    on<FetchAllTransactionFromLocalEvent>(_onFetchAllTransactionFromStorage);
  }

  Future<void> _onCreateTransaction(
    CreateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit((TransactionLoadingState()));
    try {
      final Result result =
          await transactionRepo.createTransaction(event.requestData);

      if (result.isSuccess) {
        emit(const TransactionCreateSuccessState(
            successMsg: "Transaction created successfully!"));
      } else {
        emit(TransactionErrorState(
            errMessage: result.failure?.statusMessage ?? ""));
      }
    } catch (_) {
      emit(const TransactionErrorState(errMessage: "Something went wrong!"));
    }
  }

  Future<void> _onFetchAllTransaction(
    FetchAllTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit((TransactionLoadingState()));
    try {
      final Result result = await transactionRepo.fetchAllTransactions();

      if (result.isSuccess) {
        var transactionHistoryData =
            result.successResponse as TransactionHistoryData;
        // Clear the existing data in the database before saving the new list
        await DatabaseUtils().clearDatabase();
        DatabaseUtils().insertTransactionList(transactionHistoryData.data);
        debugPrint("InsertedRowCount => insertedRows");
        emit(TransactionSuccessState(historyData: transactionHistoryData.data));
      } else {
        emit(TransactionErrorState(
            errMessage: result.failure?.statusMessage ?? ""));
      }
    } catch (_) {
      emit(const TransactionErrorState(errMessage: "Something went wrong!"));
    }
  }

  Future<void> _onFetchAllTransactionFromStorage(
    FetchAllTransactionFromLocalEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit((TransactionLoadingState()));
    try {
      debugPrint("InsertedRowCount => {transactionHistoryData.length}");
      List<TransactionData> transactionHistoryData =
          await DatabaseUtils().getTransactionMapList();
      debugPrint("InsertedRowCount => ${transactionHistoryData.length}");
      emit(TransactionSuccessState(historyData: transactionHistoryData));
    } catch (_) {
      emit(const TransactionErrorState(errMessage: "Something went wrong!"));
    }
  }
}
