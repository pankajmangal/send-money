class ApiEndpoints {

  static ApiEndpoints? instance;

  ApiEndpoints._() {
    // initialization and stuff
  }

  factory ApiEndpoints() {
    instance ??= ApiEndpoints._();
    return instance!;
  }

  //Base url here....
  static const baseUrl = "https://jsonplaceholder.typicode.com";

  //Endpoints here...
  static const loginUrl = "/authenticate";
}