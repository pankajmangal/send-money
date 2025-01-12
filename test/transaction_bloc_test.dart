import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_bloc.dart';
import 'package:send_money/data/models/response/transaction_history_data.dart';
import 'package:send_money/data/network/remote/api_endpoints.dart';
import 'package:send_money/data/network/remote/api_result.dart';
import 'package:send_money/data/network/remote/dio_exceptions.dart';
import 'package:send_money/data/repository/transaction_repo.dart';

class MockTransactionRepo extends Mock implements TransactionRepo {}

// class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("Test Unit test", (){
    expect(3/2, (1.5));
  });

  group("Transaction Bloc success Scenarios", (){
    late Dio dio;
    late DioAdapter dioAdapter;
    late MockTransactionRepo mockTransactionRepo;
    late TransactionHistoryBloc historyBloc;
    const transactionUrl = "api/transaction-history";
    const data = {
      "data": [
  {
    "_id": "6782552130f508a7a13239e3",
    "transactionID": "678243df40eedbcdb00074e6",
    "amount": "104.53",
    "createdAt": "2025-01-11T11:25:21.902Z",
    "__v": 0
  },
  {
    "_id": "678253e330f508a7a13239cf",
    "transactionID": "678243df40eedbcdb00074e6",
    "amount": "14.9",
    "createdAt": "2025-01-11T11:20:03.834Z",
    "__v": 0
  },
  {
    "_id": "6782524730f508a7a13239c1",
    "transactionID": "678243df40eedbcdb00074e6",
    "amount": "34.5",
    "createdAt": "2025-01-11T11:13:11.123Z",
    "__v": 0
  }
    ]
  };
    
    setUp(() async {
      final header = {
      'Content-Type': 'application/json',
      'user_agent':Platform.isAndroid ? "android" : "ios",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzVlZTI1NjJhYmI3YzUyZDAyZTJiY2YiLCJpYXQiOjE3MzUzMTEwMDV9.rmz5eZ53-oxVLKRcQ2qb1uXXnYuSVnXJsPsD73H5Gh0"
      };
      dio = Dio(BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(
            milliseconds: 120000), // 300000 = 60 * 2 * 1000 => 2 minute
        receiveTimeout: const Duration(
            milliseconds: 120000), // 300000 = 60 * 2 * 1000 => 2 minute
      ));
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
          when(() {
            mockTransactionRepo.fetchAllTransactions().then((result) => Result.failure(failure: Failure(errorType: DioExceptionType.badResponse)));});
          return historyBloc;
        },
        // verify: (_) async { verify(await mockTransactionRepo.fetchAllTransactions()).called(1);},
        act: (dynamic b) => b.add(FetchAllTransactionFromServerEvent()),
    wait:  const Duration(milliseconds: 5000),
    expect: () => [TransactionHistoryLoadingState(), const TransactionHistoryErrorState(errMessage: "Something went wrong!")]);

    /*blocTest<TransactionHistoryBloc, TransactionHistoryState>(
        "When data is not empty",
        build: () {
          when(() => mockTransactionRepo.fetchAllTransactions().then((result) => Result.success(successResponse: TransactionHistoryData(data: []))));
          return historyBloc;
        }*//*TransactionHistoryBloc(transactionRepo: MockTransactionRepo())*//*,
        act: (dynamic b) => b.add(FetchAllTransactionFromServerEvent()),
        wait:  const Duration(milliseconds: 5000),
        expect: () => [TransactionHistoryLoadingState(), const TransactionHistorySuccessState(historyData: [])]);*/
  });
}