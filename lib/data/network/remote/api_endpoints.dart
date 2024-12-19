class ApiEndpoints {

  static final ApiEndpoints _instance = ApiEndpoints._internal();

  factory ApiEndpoints(){
    return _instance;
  }

  ApiEndpoints._internal();

  //Base url here....
  // static const baseUrl = "http://10.0.2.2:3000/";
  static const baseUrl = "https://8757-2401-4900-5fbf-eec-95bd-8e34-6919-bc55.ngrok-free.app/";

  //Api endpoints here...
  static const loginUrl = "api/authenticate";
  static const String createTransactionUrl = "api/transaction-history";
  static const String transactionHistoryUrl = "";
  static const String userDataUrl = "api/user";
}