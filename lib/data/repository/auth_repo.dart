import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:send_money/data/models/transaction_history_data.dart';
import 'package:send_money/data/models/user_authenticate_request_data.dart';
import 'package:send_money/data/network/remote/api_endpoints.dart';
import 'package:send_money/data/network/remote/dio_client.dart';

class AuthRepo {
  final _dioClient = DioClient();

  Future<bool> userAuthenticate(UserAuthenticateRequestData requestData) async {
    try {
      final result = await _dioClient.postMethod(urlPath: ApiEndpoints.loginUrl, data: requestData.userRequestToJson());
      if (result.statusCode != 200) {
        throw Exception();
      }
      debugPrint("TransactionData => ${result.data}");
      final response = json.decode(result.data);
      return true;
    }catch(e) {
      debugPrint("TransactionData => ${e.toString()}");
      return false;
    }
  }
}