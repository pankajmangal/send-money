import 'package:equatable/equatable.dart';

abstract class TransactionHistoryEvent extends Equatable{
  const TransactionHistoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllTransactionFromServerEvent extends TransactionHistoryEvent {}

class FetchAllTransactionFromLocalEvent extends TransactionHistoryEvent {}