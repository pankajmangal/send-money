import 'package:equatable/equatable.dart';
import 'package:send_money/data/models/response/transaction_history_data.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitialState extends TransactionState{}

class TransactionLoadingState extends TransactionState{}

class TransactionSuccessState extends TransactionState{
  final TransactionHistoryData historyData;

  const TransactionSuccessState({required this.historyData});

  @override
  List<Object> get props => [historyData];
}

class TransactionCreateSuccessState extends TransactionState{
  final String successMsg;

  const TransactionCreateSuccessState({required this.successMsg});

  @override
  List<Object> get props => [successMsg];
}

class TransactionErrorState extends TransactionState{
  final String errMessage;

  const TransactionErrorState({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}