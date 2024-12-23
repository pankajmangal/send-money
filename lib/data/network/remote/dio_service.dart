import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:send_money/data/network/local/secure_storage_service.dart';
import 'package:send_money/data/network/remote/api_endpoints.dart';
import 'package:send_money/data/network/remote/dio_interceptor.dart';
import 'network_enums.dart';

class DioService {

  static Future<Response> makeRESTRequest<T extends Object>(
      {required String urlPath,
      String? baseUrl,
      BaseOptions? baseOptions,
      List<Interceptor>? specificInterceptors,
      required RequestMethod method,
        bool useAuthHeader = false,
      T? data}) async {
    Dio dio = Dio(baseOptions == null
        ? BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            method: method.getMethodName,
            receiveTimeout: const Duration(seconds: 120),
    headers: useAuthHeader ? await getHeaders() : {})
        : baseOptions.copyWith(
            baseUrl: ApiEndpoints.baseUrl,
            method: method.getMethodName,
            receiveTimeout: const Duration(seconds: 120),
        headers: useAuthHeader ? await getHeaders() : {}));

    dio.options.headers['user_agent'] = Platform.isAndroid?"android":"ios";
    // dio.options.headers["user_ip"] = AECommonUtils.deviceIPAddress.value;

    if (specificInterceptors != null) {
      dio.interceptors.addAll(specificInterceptors);
    }

    // dio.interceptors.add(RefreshTokenInterceptor(dio: dio));

    dio.interceptors.addAll([
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90),
      RetryInterceptor(
          retries: 1,
          retryEvaluator: (error, attempt) =>
              error.error is! SocketException &&
              error.type == DioExceptionType.connectionTimeout,
          logPrint: (message) => log(message),
          dio: dio),
      DefaultInterceptor(),
    ]);
    switch (method) {
      case RequestMethod.getRequest:
        return data == null ? dio.get(urlPath)
            : dio.get(urlPath, queryParameters: data as Map<String, dynamic>).then((value) => value);
      case RequestMethod.postRequest:
        return dio.post(urlPath, data: data).then((value) => value);
      case RequestMethod.putRequest:
        return dio.put(urlPath, data: data).then((value) => value);
      case RequestMethod.deleteRequest:
        return dio.delete(urlPath, data: data).then((value) => value);
      case RequestMethod.patchRequest:
        return dio.patch(urlPath, data: data).then((value) => value);
      case RequestMethod.headRequest:
        return dio.head(urlPath, data: data).then((value) => value);
    }
  }

  static Future<Map<String, String>> getHeaders() async {
    final SecureStorageService storageService = SecureStorageService();
    final token = await storageService.getAccessToken();
    debugPrint("CustomerToken => $token");
    if (token.isNotEmpty) {
      return {
        'Content-Type': 'application/json',
        'user_agent':Platform.isAndroid ? "android" : "ios",
        "Authorization": "Bearer $token"
      };
    } else {
      return {
        'Content-Type': 'application/json',
        'user_agent':Platform.isAndroid?"android":"ios"
      };
    }
  }
}