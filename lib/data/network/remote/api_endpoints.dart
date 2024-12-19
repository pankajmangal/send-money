class ApiEndpoints {

  static final ApiEndpoints _instance = ApiEndpoints._internal();

  factory ApiEndpoints(){
    return _instance;
  }

  ApiEndpoints._internal();

  //Base url here....
  static const baseUrl = "http://10.0.2.2:3000/";

  //Api endpoints here...
  static const loginUrl = "api/authenticate";
  static const String createTransactionUrl = "api/transaction-history";
  static const String transactionHistoryUrl = "";
  static const String userDataUrl = "api/user";
}