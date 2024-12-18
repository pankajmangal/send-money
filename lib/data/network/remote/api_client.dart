class APIClient {
  static final APIClient _instance = APIClient._internal();

  factory APIClient(){
    return _instance;
  }

  APIClient._internal();

  static const String baseUrl = "";

  //Api endpoints here...
  static const String loginUrl = "";
  static const String transactionHistoryUrl = "";
  static const String userDataUrl = "";
}