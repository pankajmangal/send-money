import 'package:send_money/data/network/remote/dio_exceptions.dart';

class Result<T> {
  final T? successResponse;
  final Failure? failure;

  Result.success({required this.successResponse}) : failure = null;

  Result.failure({required this.failure}) : successResponse = null;

  bool get isSuccess => successResponse != null;

  bool get isFailure => failure != null;

  @override
  String toString() =>
      isSuccess ? successResponse.toString() : failure.toString();
}