import 'package:dio/dio.dart';

class GraphApi {
  static const String _forecastPath = '/monitoring';
  final Dio _dio;

  GraphApi(this._dio);

  Future<Response> getMonitoringData(String type, String date) async {
    return _dio.get(_forecastPath, queryParameters: {'type': type, 'date': date});
  }
}
