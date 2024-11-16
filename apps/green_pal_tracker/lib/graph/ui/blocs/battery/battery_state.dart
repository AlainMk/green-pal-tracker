part of 'battery_bloc.dart';

abstract mixin class BatteryState {
  const BatteryState();
}

class LoadingBatteryState extends Equatable with BatteryState {
  const LoadingBatteryState();

  @override
  List<Object?> get props => [];
}

class ErrorBatteryState extends Equatable with BatteryState {
  const ErrorBatteryState({this.message = 'An error occurred'});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SuccessBatteryState extends BaseSuccessGraphState with BatteryState {
  const SuccessBatteryState(
    List<GraphData> data,
    EnergyUnit unit,
    DateTime date,
  ) : super(data: data, unit: unit, date: date);

  SuccessBatteryState copyWith({
    List<GraphData>? data,
    EnergyUnit? unit,
    DateTime? date,
  }) {
    return SuccessBatteryState(
      data ?? this.data,
      unit ?? this.unit,
      date ?? this.date,
    );
  }
}
