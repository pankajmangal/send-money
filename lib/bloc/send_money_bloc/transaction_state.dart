import 'package:equatable/equatable.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitialState extends TransactionState{}

class TransactionLoadingState extends TransactionState{}

class TransactionSuccessState extends TransactionState{
  final String successMsg;

  const TransactionSuccessState({required this.successMsg});

  @override
  List<Object> get props => [successMsg];
}

class TransactionErrorState extends TransactionState{
  final String errMessage;

  const TransactionErrorState({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}