
enum RequestMethod {
  getRequest,
  postRequest,
  putRequest,
  deleteRequest,
  patchRequest,
  headRequest
}

extension RESTMethodString on RequestMethod {
  String get getMethodName {
    switch (this) {
      case RequestMethod.getRequest:
        return "GET";
      case RequestMethod.postRequest:
        return "POST";
      case RequestMethod.putRequest:
        return "PUT";
      case RequestMethod.deleteRequest:
        return "DELETE";
      case RequestMethod.patchRequest:
        return "PATCH";
      case RequestMethod.headRequest:
        return "HEAD";
    }
  }
}