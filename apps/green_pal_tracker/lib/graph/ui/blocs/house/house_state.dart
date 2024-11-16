part of 'house_bloc.dart';

abstract mixin class HouseState {
  const HouseState();
}

class LoadingHouseState extends Equatable with HouseState {
  const LoadingHouseState();

  @override
  List<Object?> get props => [];
}

class ErrorHouseState extends Equatable with HouseState {
  const ErrorHouseState({this.message = 'An error occurred'});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SuccessHouseState extends BaseSuccessGraphState with HouseState {
  const SuccessHouseState(
    List<GraphData> data,
    EnergyUnit unit,
    DateTime date,
  ) : super(data: data, unit: unit, date: date);

  SuccessHouseState copyWith({
    List<GraphData>? data,
    EnergyUnit? unit,
    DateTime? date,
  }) {
    return SuccessHouseState(
      data ?? this.data,
      unit ?? this.unit,
      date ?? this.date,
    );
  }
}
