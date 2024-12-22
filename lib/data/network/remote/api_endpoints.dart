class ApiEndpoints {

  static final ApiEndpoints _instance = ApiEndpoints._internal();

  factory ApiEndpoints(){
    return _instance;
  }

  ApiEndpoints._internal();

  //Base url here....
  // static const baseUrl = "http://10.0.2.2:3000/";
  static const baseUrl = "https://9a18-2401-4900-1c68-671c-44d9-c338-463f-baab.ngrok-free.app/";

  //Api endpoints here...
  static const loginUrl = "api/authenticate";
  static const String createTransactionUrl = "api/create-transaction";
  static const String transactionHistoryUrl = "api/transaction-history";
  static const String userDataUrl = "api/user";
}