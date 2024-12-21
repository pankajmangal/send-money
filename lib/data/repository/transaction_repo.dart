import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:send_money/data/models/request/create_transaction_request_data.dart';
import 'package:send_money/data/models/response/transaction_history_data.dart';
import 'package:send_money/data/models/request/user_authenticate_request_data.dart';
import 'package:send_money/data/network/remote/api_endpoints.dart';
import 'package:send_money/data/network/remote/api_result.dart';
import 'package:send_money/data/network/remote/dio_client.dart';
import 'package:send_money/data/network/remote/dio_exceptions.dart';
import 'package:send_money/data/network/remote/dio_service.dart';
import 'package:send_money/data/network/remote/network_enums.dart';

class TransactionRepo {

  //We are validating user here...
  Future<Result> createTransaction(CreateTransactionRequestData requestData) async {
      try {
        Response response = await DioService.makeRESTRequest(
            urlPath: ApiEndpoints.createTransactionUrl,
            method: RequestMethod.postRequest,
          useAuthHeader: true,
          data: requestData.transactionToJson()
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint("loginResponse => ${response.statusCode} :: ${response.data}");
          return Result.success(successResponse: response.data);
        }else{
          throw Exception(response.data);
        }
      } on DioException catch (e) {
        return Result<Failure>.failure(
            failure: CustomDioExceptions.fromDioError(
                dioError: e,
                messageType: ErrorMessageType.messageFromResponseBody,
                messagePath: "message"));
      } on ResponseParsingException catch (e) {
        return Result<Failure>.failure(
            failure: Failure(
                errorType: DioExceptionType.unknown,
                statusMessage: e.toString()));
      } catch (e) {
        return Result<Failure>.failure(
            failure: Failure(
                errorType: DioExceptionType.unknown,
                statusMessage: "oops..Something went wrong"));
      }
    }
}