import 'package:green_pal_tracker/graph/data/models/graph_data.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';

class GraphDataItem {
  final GraphData _data;
  final EnergyUnit unit;

  GraphDataItem(this._data, this.unit);

  int get value {
    if (unit == EnergyUnit.watt) {
      return _data.value;
    } else {
      return (_data.value / 1000).round();
    }
  }

  DateTime get timestamp => DateTime.parse(_data.timestamp);
}
