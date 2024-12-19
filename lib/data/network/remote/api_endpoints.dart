class ApiEndpoints {

  static final ApiEndpoints _instance = ApiEndpoints._internal();

  factory ApiEndpoints(){
    return _instance;
  }

  ApiEndpoints._internal();

  //Base url here....
  // static const baseUrl = "http://10.0.2.2:3000/";
  static const baseUrl = "https://b767-2401-4900-5fbf-eec-44bc-2b06-7724-eea3.ngrok-free.app/";

  //Api endpoints here...
  static const loginUrl = "api/authenticate";
  static const String createTransactionUrl = "api/transaction-history";
  static const String transactionHistoryUrl = "";
  static const String userDataUrl = "api/user";
}