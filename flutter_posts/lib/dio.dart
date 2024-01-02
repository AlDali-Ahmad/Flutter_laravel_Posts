import 'package:dio/dio.dart';
import 'package:flutter_posts/providers/auth.dart';

Dio dio() {
  var dio = Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/api/',
      responseType: ResponseType.plain,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
      }));

  dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        RequestInterceptorr(options);
        return handler.next(options);
      },
    ),
  );

  return dio;
}

dynamic RequestInterceptorr(RequestOptions options) async {
  if (options.headers.containsKey('auth')) {
    var token = await Auth().getToken();
    options.headers.addAll({'Authorization': 'Bearer $token'});
  }
}
