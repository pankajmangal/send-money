import 'package:dio/dio.dart';
import 'package:send_money/data/network/local/secure_storage_service.dart';

class RefreshTokenInterceptor extends Interceptor {

  final Dio dio;

  RefreshTokenInterceptor({required this.dio});

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add the access token to the request header

    String accessToken = await SecureStorageService().getAccessToken();
    String refreshToken = await SecureStorageService().getRefreshToken();
    options.headers["Cookie"] = "accessToken=$accessToken;refreshToken=$refreshToken";

    return handler.next(options);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // print("!!!---mohit----11111");
    // print(err.response.toString());
    // print(err.response?.requestOptions.data.toString());
    // print(err.response?.requestOptions.path.toString());
    // print(err.response?.requestOptions.method.toString());

    String refreshToken = await SecureStorageService().getRefreshToken();

    if ((err.response?.statusCode == 401) && refreshToken.isNotEmpty) {

      // Refresh the access token
      // RefreshTokenModel refreshTokenModel = await AuthRepo().refreshTokenCall();

      // await SecureStorageService().saveAccessToken(refreshTokenModel.accessToken ?? '');
      // await SecureStorageService().saveRefreshToken(refreshTokenModel.refreshToken ?? '');

      String accessToken = await SecureStorageService().getAccessToken();
      refreshToken = await SecureStorageService().getRefreshToken();
      // Update the request header with the new access token
      dio.options.headers["Cookie"] = "accessToken=$accessToken;refreshToken=$refreshToken";

      // Retry the request with the updated header
      return handler.resolve(await dio.fetch(err.requestOptions));
    }
    return handler.next(err);
  }
}