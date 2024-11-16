part of 'solar_bloc.dart';

abstract mixin class SolarState {
  const SolarState();
}

class LoadingSolarState extends Equatable with SolarState {
  const LoadingSolarState();

  @override
  List<Object?> get props => [];
}

class ErrorSolarState extends Equatable with SolarState {
  const ErrorSolarState({this.message = 'An error occurred'});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SuccessSolarState extends BaseSuccessGraphState with SolarState {
  const SuccessSolarState(
    List<GraphData> data,
    EnergyUnit unit,
    DateTime date,
  ) : super(data: data, unit: unit, date: date);

  SuccessSolarState copyWith({
    List<GraphData>? data,
    EnergyUnit? unit,
    DateTime? date,
  }) {
    return SuccessSolarState(
      data ?? this.data,
      unit ?? this.unit,
      date ?? this.date,
    );
  }
}
