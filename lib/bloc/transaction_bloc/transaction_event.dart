import 'package:equatable/equatable.dart';
import 'package:send_money/data/models/request/create_transaction_request_data.dart';
import 'package:send_money/data/models/request/user_authenticate_request_data.dart';

abstract class TransactionEvent extends Equatable{
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class CreateTransactionEvent extends TransactionEvent {
  final CreateTransactionRequestData requestData;

  const CreateTransactionEvent({required this.requestData});

  @override
  List<Object?> get props => [requestData];
}

class FetchAllTransactionEvent extends TransactionEvent {}