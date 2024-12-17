import 'package:equatable/equatable.dart';
import 'package:send_money/data/models/transaction_history_data.dart';

class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();

  @override
  List<Object> get props => [];
}

class TransactionInitialState extends TransactionHistoryState {}

class TransactionLoadingState extends TransactionHistoryState {}

class TransactionSuccessState extends TransactionHistoryState {
  final TransactionHistoryData data;

 const TransactionSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}

class TransactionFailureState extends TransactionHistoryState {}