import 'package:equatable/equatable.dart';
import 'package:green_pal_tracker/graph/data/models/graph_data.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';
import 'package:green_pal_tracker/graph/ui/blocs/shared/graph_data_item.dart';

abstract class BaseSuccessGraphState extends Equatable {
  final List<GraphData> data;
  final EnergyUnit unit;
  final DateTime date;

  const BaseSuccessGraphState({required this.data, required this.unit, required this.date});

  List<GraphDataItem> get dataList => data.map((e) => GraphDataItem(e, unit)).toList();

  String get formatedUnit => unit == EnergyUnit.watt ? 'W' : 'KW';

  String get totalEnergyGenerated {
    final total = dataList.fold(0, (previousValue, element) => previousValue + element.value);
    return "$total $formatedUnit";
  }

  @override
  List<Object?> get props => [data, unit, date];
}
