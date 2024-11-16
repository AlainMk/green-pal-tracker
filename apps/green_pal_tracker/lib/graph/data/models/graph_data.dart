class GraphData {
  final String timestamp;
  final int value;

  GraphData({required this.timestamp, required this.value});

  factory GraphData.fromJson(Map<String, dynamic> json) {
    return GraphData(
      timestamp: json['timestamp'],
      value: json['value'],
    );
  }

  static List<GraphData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GraphData.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'value': value,
    };
  }
}
