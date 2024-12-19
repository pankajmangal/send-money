import 'dart:developer';

import 'package:dio/dio.dart';

class DefaultInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("Error occured");
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("Send Request from Main Interceptor..Please Await response");
    log(options.data.toString());
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("Sucessfully got Response Main Interceptor");
    handler.next(response);
  }
}
