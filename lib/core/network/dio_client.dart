import 'package:dio/dio.dart';
import 'api_config.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Authorization": "Bearer ${ApiConfig.bearerToken}",
          "Accept": "application/json",
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }
}
