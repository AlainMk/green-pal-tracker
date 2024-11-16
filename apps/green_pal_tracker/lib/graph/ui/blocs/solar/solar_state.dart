part of 'solar_bloc.dart';

sealed class SolarState extends Equatable {
  const SolarState();
}

class LoadingSolarState extends SolarState {
  const LoadingSolarState();

  @override
  List<Object?> get props => [];
}

class ErrorSolarState extends SolarState {
  const ErrorSolarState({this.message = 'An error occurred'});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SuccessSolarState extends SolarState {
  const SuccessSolarState(this._data, this.unit, this.date);

  final List<GraphData> _data;
  final EnergyUnit unit;
  final DateTime date;

  List<GraphDataItem> get dataList => _data.map((e) => GraphDataItem(e, unit)).toList();

  String get formatedUnit => unit == EnergyUnit.watt ? 'W' : 'KW';

  String get totalEnergyGenerated {
    final total = dataList.fold(0, (previousValue, element) => previousValue + element.value);
    return "${total.toStringAsFixed(2)} $formatedUnit";
  }

  @override
  List<Object?> get props => [_data, unit, date];

  SuccessSolarState copyWith({
    List<GraphData>? data,
    EnergyUnit? unit,
    DateTime? date,
  }) {
    return SuccessSolarState(
      data ?? _data,
      unit ?? this.unit,
      date ?? this.date,
    );
  }
}
