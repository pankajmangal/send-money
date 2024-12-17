import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:send_money/data/models/transaction_history_data.dart';
import 'package:send_money/data/network/remote/dio_client.dart';

class TransactionHistoryRepo {
  final _dioClient = DioClient();

  Future<TransactionHistoryData> getTransactionData() async {
    try {
      final result = await _dioClient.getMethod(url: "/transaction");
      if (result.statusCode != 200) {
        throw Exception();
      }
      debugPrint("TransactionData => ${result.data}");
      final response = json.decode(result.data);
      return TransactionHistoryData.fromJson(response);
    }catch(e) {
      debugPrint("TransactionData => ${e.toString()}");
      return TransactionHistoryData();
    }
  }
}