import 'dart:io';
import 'package:dio/dio.dart';

class CustomDioExceptions implements Exception {
  CustomDioExceptions._();
  static Failure fromDioError(
      {required DioException dioError,
      String? messagePath,
      ErrorMessageType? messageType = ErrorMessageType.messageCustomised}) {

    if (dioError.error is SocketException || dioError.error is HttpException) {
      return Failure(
          errorType: dioError.type,
          isResponseErr: false,
          statusMessage: "Please check your Network Connectivity");
    } else {
      switch (dioError.type) {
        case DioExceptionType.cancel:
          return Failure(
              errorType: dioError.type,
              isResponseErr: false,
              statusMessage: "Request to API server was cancelled");

        case DioExceptionType.connectionTimeout:
          return Failure(
              errorType: dioError.type,
              isResponseErr: false,
              statusMessage: "mmm...its taking too long,try again");

        case DioExceptionType.unknown:
          return Failure(
              errorType: dioError.type,
              isResponseErr: false,
              statusMessage:
                  "Oops..We have hit a snag. Please try again later");

        case DioExceptionType.receiveTimeout:
          return Failure(
              errorType: dioError.type,
              isResponseErr: false,
              statusMessage:
                  "oops its taking too long than expected,try again");
        case DioExceptionType.badResponse:
          return handleResponseError(
            messagePath: messagePath,
            statusCode: dioError.response!.statusCode!,
            errorMessageType: messageType!,
            error: dioError,
          );
        case DioExceptionType.sendTimeout:
          return Failure(
              errorType: dioError.type,
              isResponseErr: false,
              statusMessage: "Send timeout,try again");
        case DioExceptionType.badCertificate:
          return Failure(
              errorType: dioError.type,
              isResponseErr: false,
              statusMessage: "Bad Certificate");

        default:
          return Failure(
              errorType: dioError.type,
              isResponseErr: false,
              statusMessage: "Unknown Error...try again later");
      }
    }
  }

  static Failure handleResponseError(
      {required int statusCode,
      required DioException error,
      String? messagePath,
      ErrorMessageType errorMessageType = ErrorMessageType.messageCustomised}) {
    assert(
        errorMessageType == ErrorMessageType.messageFromResponseBody
            ? messagePath != null
            : true,
        "Pls provide the path to the response error message");
    String serverMessage = '';
    try {
      serverMessage = error.response?.data[messagePath].toString() ??
          "Err Message From Server---->[Message] is not found";
    } catch (e) {
      serverMessage = 'No key in the response called  [$messagePath] found..';
      serverMessage="";
    }

    switch (statusCode) {
      case 300:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "Multiple options for the requested resource");
      case 301:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage: "Resource has been permanently moved");
      case 302:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "Resource temporarily found at a different location");
      case 303:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage: "Redirect to another resource");
      case 304:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "Resource not modified since the last request");
      case 305:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "Must access the requested resource through a proxy");
      case 307:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage: "Temporary redirect to another resource");
      case 308:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage: "Permanent redirect to another resource");
      case 310:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage: "Too many redirects encountered");
      case 400:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server could not understand the request due to invalid syntax or missing parameters.");
      case 401:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage: "Un Authorised Request");
      case 403:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server understood the request, but is refusing to fulfill it.");
      case 404:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The requested resource could not be found.");
      case 405:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The request method is not supported for the requested resource.");
      case 406:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The requested resource is not capable of generating a response matching the list of acceptable values defined in the request's headers.");
      case 408:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server timed out waiting for the request.");
      case 409:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The request could not be completed due to a conflict with the current state of the resource.");
      case 410:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The requested resource is no longer available and has been permanently removed.");
      case 411:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server requires a Content-Length header to be included in the request.");
      case 412:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server detected a pre-condition failure.");
      case 413:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The payload size exceeds the maximum allowed.");
      case 414:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The URI requested by the client is too long for the server to process.");
      case 415:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The media type of the requested data is not supported by the server.");
      case 416:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The range specified by the Range header field in the request can't be fulfilled.");
      case 417:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The expectation given in the request's Expect header field could not be met.");
      case 418:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type, statusMessage: "I'm a teapot.");
      case 422:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server understands the content type of the request entity, but was unable to process the contained instructions.");
      case 425:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server is unwilling to risk processing a request that might be replayed.");
      case 426:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The client should switch to a different protocol such as TLS/1.3, given in the Upgrade header field.");
      case 428:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server requires the request to be conditional.");
      case 429:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The user has sent too many requests in a given amount of time.");
      case 431:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server is unwilling to process the request because its header fields are too large.");
      case 451:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server is denying access to a resource as a consequence of a legal demand.");
      case 500:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        "The server encountered an unexpected condition that prevented it from fulfilling the request.");
      case 501:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        'The server does not support the functionality required to fulfill the request.');
      case 502:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        'The server received an invalid response from an upstream server while attempting to fulfill the request.');
      case 503:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage:
                        'The server is currently unable to handle the request due to a temporary overload or maintenance.');
      case 504:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type, statusMessage: 'Gateway Timeout');
      case 505:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage: 'HTTP Version Not Supported');
      case 506:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage: 'Variant Also Negotiates');
      case 507:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage: 'Insufficient Storage');
      case 508:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type, statusMessage: 'Loop Detected');
      case 510:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(errorType: error.type, statusMessage: 'Not Extended');
      case 511:
        return errorMessageType == ErrorMessageType.messageFromResponseBody
            ? Failure(errorType: error.type, statusMessage: serverMessage)
            : errorMessageType == ErrorMessageType.messageDefaultByDio
                ? Failure(errorType: error.type, statusMessage: error.message)
                : Failure(
                    errorType: error.type,
                    statusMessage: 'Network Authentication Required');
      default:
        return Failure(errorType: error.type, statusMessage: error.message);
    }
  }
}

class Failure implements Exception {
  bool? isResponseErr;
  String? statusMessage;
  DioExceptionType errorType;

  Failure(
      {this.isResponseErr = true,
      required this.errorType,
      this.statusMessage = "oops..We have hit a snag"});

  @override
  String toString() {
    return statusMessage.toString();
  }

  Failure copyWith({String? statusMessage}) {
    return Failure(
      isResponseErr: isResponseErr,
      statusMessage: statusMessage ?? this.statusMessage,
      errorType: errorType,
    );
  }
}

enum ErrorMessageType {
  messageFromResponseBody,
  messageDefaultByDio,
  messageCustomised
}

class ResponseParsingException implements Exception {
  String? errorMessage;
  ResponseParsingException(
      {this.errorMessage =
          "Response received successfully..Unable to parse JSON"});

  @override
  String toString() => '$errorMessage';
}