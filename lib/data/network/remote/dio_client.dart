import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:send_money/data/network/remote/api_endpoints.dart';

class DioClient {
  //Singleton instance creation....

  static DioClient? instance;

  DioClient._() {
    // initialization and stuff
  }

  factory DioClient() {
    instance ??= DioClient._();
    return instance!;
  }

  CancelToken? cancelToken;

  //Dio instantiation with base option & interceptors....
  Dio dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(
        milliseconds: 300000), // 300000 = 60 * 2 * 1000 => 2 minute
    receiveTimeout: const Duration(
        milliseconds: 300000), // 300000 = 60 * 2 * 1000 => 2 minute
  ))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        enabled: true,
        compact: true,
        maxWidth: 90)
    );

  //Generic post method for API calls.....
  Future<Response> postMethod(
      {required String urlPath,
        dynamic data,
        bool isFormData = false,
        bool useAuthHeader = false,
        option}) async {
    cancelToken = CancelToken();
    Map<String, dynamic> headers = useAuthHeader ? await getHeaders() : {};
    option = Options(method: "post");
    option.headers = headers;

    if (!isFormData) {
      debugPrint("request==>> ${jsonEncode(data)}");
    }

    return await dio
        .post(urlPath, data: data, options: option, cancelToken: cancelToken)
        .then((value) => value);
  }

  //Generic get method for API calls.....
  Future<Response> getMethod(
      {required String url,
        Map<String, dynamic>? queryData,
        bool useAuthHeader = true,
        option}) async {
    cancelToken = CancelToken();
    Map<String, dynamic> headers = useAuthHeader ? await getHeaders() : {};
    option = Options(method: "get");
    option.headers = headers;
    return await dio
        .get(url, queryParameters: queryData, options: option, cancelToken: cancelToken)
        .then((value) => value);
  }

  //Generic put method for API calls.....
  Future<Response> putMethod(
      {required String url,
        dynamic data,
        bool useAuthHeader = false,
        option}) async {
    cancelToken = CancelToken();
    Map<String, dynamic> headers = useAuthHeader ? await getHeaders() : {};
    option = Options(method: "put");
    option.headers = headers;
    return await dio.put(url, data: data, options: option,
        cancelToken: cancelToken).then((value) => value);
  }

  //Generic delete method for API calls.....
  Future<Response> deleteMethod(
      {required String url,
        dynamic data,
        bool useAuthHeader = false,
        option}) async {
    cancelToken = CancelToken(); //Assigned always new token and
    Map<String, dynamic> headers = useAuthHeader ? await getHeaders() : {};
    option = Options(method: "delete");
    option.headers = headers;
    return dio.delete(url, data: data, options: option, cancelToken: cancelToken).then((value) => value);
  }

  Future<Map<String, String>> getHeaders() async {
    // final token = await UtilityFunctions.getTokenFromSharedPreferences();
    // debugPrint("CustomerToken => $token");
    // if (token.isNotEmpty) {
    //   return {
    //     'Content-Type': 'application/json',
    //     "Authorization": "Bearer $token",
    //   };
    // } else {
    //   return {
    //     'Content-Type': 'application/json',
    //   };
    // }
    return {
      'Content-Type': 'application/json',
      'user_agent':Platform.isAndroid?"android":"ios",
    };
  }
}