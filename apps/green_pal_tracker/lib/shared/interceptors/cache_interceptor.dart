import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CacheInterceptor extends Interceptor {
  final Duration cacheDuration;
  CacheInterceptor({this.cacheDuration = const Duration(minutes: 10)});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint("::: Api error : $err");
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("::: Api response : ${response.data}");
    // final statusCode = response.statusCode;
    // if (statusCode != null && statusCode >= 200 && statusCode < 300) {
    //   final cacheKey = response.requestOptions.uri.toString();
    //   box.put(cacheKey, response.data);
    // }
    return handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("::: Api request : ${options.uri}");
    // final cacheKey = options.uri.toString();
    // final entry = box.get(cacheKey);
    // if (entry != null) {
    //   return handler.resolve(Response(requestOptions: options, data: entry));
    // }
    return handler.next(options);
  }
}
