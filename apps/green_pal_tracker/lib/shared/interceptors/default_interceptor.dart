import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DefaultInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint("::: Api error : $err");
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("::: Api response : ${response.data}");
    return handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("::: Api request : ${options.uri}");
    return handler.next(options);
  }
}
