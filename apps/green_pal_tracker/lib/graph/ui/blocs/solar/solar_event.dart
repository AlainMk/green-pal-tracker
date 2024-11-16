part of 'solar_bloc.dart';

sealed class SolarEvent extends Equatable {
  const SolarEvent();
}

class GetSolarData extends SolarEvent {
  const GetSolarData({this.date});

  final DateTime? date;

  @override
  List<Object?> get props => [date];
}

class ChangeUnit extends SolarEvent {
  const ChangeUnit(this.unit);

  final int unit;

  @override
  List<Object?> get props => [unit];
}

class StartPolling extends SolarEvent {
  @override
  List<Object?> get props => [];
}

class StopPolling extends SolarEvent {
  @override
  List<Object?> get props => [];
}
