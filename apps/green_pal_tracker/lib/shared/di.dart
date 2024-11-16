import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:green_pal_tracker/graph/data/api/graph_api.dart';
import 'package:green_pal_tracker/graph/data/repository/graph_repository.dart';
import 'package:green_pal_tracker/shared/interceptors/cache_interceptor.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DependencyInjector {
  static Future<void> inject() async {
    // Hive
    await _initHive();

    // API's
    GetIt.instance.registerSingleton<GraphApi>(GraphApi(_createDio()));

    // Repositories
    GetIt.instance.registerSingleton<GraphRepository>(GraphRepository());
  }

  static Dio _createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.0.78:3000",
      ),
    );
    dio.interceptors.add(
      CacheInterceptor(),
    );
    return dio;
  }

  static _initHive() async {
    await Hive.initFlutter();
    await Hive.openBox<Map>("energy");
  }
}
