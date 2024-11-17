import 'package:green_pal_tracker/graph/data/models/graph_data.dart';
import 'package:hive/hive.dart';

class GraphLocalDB {
  static const String _boxName = 'graph_data_db';

  Future<void> saveData(String key, List<GraphData> data) async {
    final box = Hive.box(_boxName);
    final jsonData = data.map((e) => e.toJson()).toList();
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    await box.put(key, {'data': jsonData, 'timestamp': timestamp});
  }

  List<GraphData>? getDataIfFresh(String key, {int freshnessMs = 10000}) {
    final box = Hive.box(_boxName);
    final cachedEntry = box.get(key);

    if (cachedEntry is! Map) return null;

    final cachedTime = (cachedEntry['timestamp'] as int?) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (now - cachedTime <= freshnessMs) {
      final jsonData = cachedEntry['data'] as List<dynamic>;
      return jsonData.map((e) => GraphData.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    return null;
  }

  List<GraphData>? getData(String key) {
    final box = Hive.box(_boxName);
    final cachedEntry = box.get(key);

    if (cachedEntry is! Map) return null;

    final jsonData = cachedEntry['data'] as List<dynamic>;
    return jsonData.map((e) => GraphData.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> clearData() async {
    final box = Hive.box(_boxName);
    await box.clear();
  }
}
