import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_bloc.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_event.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_state.dart';
import 'package:send_money/data/network/remote/api_result.dart';
import 'package:send_money/data/repository/transaction_repo.dart';

class MockTransactionRepo extends Mock implements TransactionRepo {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test("Test Unit test", (){
    expect(3/2, (1.5));
  });

  group("Transaction Bloc success Scenarios", (){
    late Dio dio;
    late DioAdapter dioAdapter;
    late MockTransactionRepo mockTransactionRepo;
    late TransactionHistoryBloc historyBloc;
    const transactionUrl = "https://21f6-2401-4900-a059-37ce-7439-7551-7c98-9196.ngrok-free.app/api/transaction-history";
    
    setUp(() async {
      final header = {
      'Content-Type': 'application/json',
      'user_agent':Platform.isAndroid ? "android" : "ios",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzVlZTI1NjJhYmI3YzUyZDAyZTJiY2YiLCJpYXQiOjE3MzUzMTEwMDV9.rmz5eZ53-oxVLKRcQ2qb1uXXnYuSVnXJsPsD73H5Gh0"
      };
      dio = Dio(
        BaseOptions(
          headers: header
        )
      );
      mockTransactionRepo = MockTransactionRepo();
      historyBloc = TransactionHistoryBloc(transactionRepo: mockTransactionRepo);
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
    });
    
    blocTest<TransactionHistoryBloc, TransactionHistoryState>(
        "When data is empty",
        // setUp: (){
        //   return dioAdapter.onGet(transactionUrl, (request) => request.reply(200, []));
        // },
        build: () {
          when(() => mockTransactionRepo.fetchAllTransactions().then((result) => Result.success(successResponse: [])));
          return historyBloc;
        }/*TransactionHistoryBloc(transactionRepo: MockTransactionRepo())*/,
        act: (dynamic b) => b.add(FetchAllTransactionFromServerEvent()),
    wait:  const Duration(milliseconds: 500),
    expect: () => [TransactionHistoryLoadingState(), const TransactionHistoryErrorState(errMessage: "Something went wrong!")]);
  });
}