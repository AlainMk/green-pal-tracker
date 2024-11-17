import 'package:dio/dio.dart';
import 'package:green_pal_tracker/graph/data/models/graph_data.dart';

final testGraphData = [
  GraphData(timestamp: "2024-11-16T12:00:00Z", value: 100),
  GraphData(timestamp: "2024-11-16T13:00:00Z", value: 150),
  GraphData(timestamp: "2024-11-16T14:00:00Z", value: 200),
];

final testGraphDataJson = [
  {'timestamp': "2024-11-16T12:00:00Z", 'value': 100},
  {'timestamp': "2024-11-16T13:00:00Z", 'value': 150},
  {'timestamp': "2024-11-16T14:00:00Z", 'value': 200},
];

final mockApiResponse = Response(
  requestOptions: RequestOptions(path: '/'),
  data: [
    {'timestamp': "2024-11-16T12:00:00Z", 'value': 100},
    {'timestamp': "2024-11-16T13:00:00Z", 'value': 150},
  ],
  statusCode: 200,
);
