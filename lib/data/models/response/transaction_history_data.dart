import 'dart:convert';

TransactionData transactionDataFromMap(String str) => TransactionData.fromMap(json.decode(str));

String transactionDataToMap(TransactionData data) => json.encode(data.toMap());

class TransactionHistoryData {
  final List<TransactionData> data;

  TransactionHistoryData({
    required this.data,
  });

  factory TransactionHistoryData.fromMap(Map<String, dynamic> json) => TransactionHistoryData(
    data: List<TransactionData>.from(json["data"].map((x) => TransactionData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class TransactionData {
  // final String id;
  final String transactionId;
  final String amount;
  final DateTime createdAt;
  // final int v;

  // required this.v,
  // required this.id,
  TransactionData({
    required this.transactionId,
    required this.amount,
    required this.createdAt
  });

  // v: json["__v"],
  // id: json["_id"],
  factory TransactionData.fromMap(Map<String, dynamic> json) => TransactionData(

    transactionId: json["transactionID"],
    amount: json["amount"],
    createdAt: DateTime.parse(json["createdAt"])
  );

  //"__v": v,
  // "_id": id,
  Map<String, dynamic> toMap() => {
    "transactionID": transactionId,
    "amount": amount,
    "createdAt": createdAt.toIso8601String()
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}