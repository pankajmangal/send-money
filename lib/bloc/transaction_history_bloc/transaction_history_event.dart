import 'package:equatable/equatable.dart';

abstract class TransactionHistoryEvent extends Equatable{
  const TransactionHistoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchTransactionDataFromServerEvent extends TransactionHistoryEvent {}

class FetchTransactionDataFromLocalEvent extends TransactionHistoryEvent {}