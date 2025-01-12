part of 'transaction_history_bloc.dart';

abstract class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();

  @override
  List<Object?> get props => [];
}

class TransactionHistoryInitialState extends TransactionHistoryState{}

class TransactionHistoryLoadingState extends TransactionHistoryState{}

class TransactionHistorySuccessState extends TransactionHistoryState{
  final List<TransactionData> historyData;

  const TransactionHistorySuccessState({required this.historyData});

  @override
  List<Object> get props => [historyData];
}

class TransactionHistoryErrorState extends TransactionHistoryState{
  final String errMessage;

  const TransactionHistoryErrorState({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}