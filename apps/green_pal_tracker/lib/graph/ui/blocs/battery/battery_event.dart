part of 'battery_bloc.dart';

sealed class BatteryEvent extends Equatable {
  const BatteryEvent();
}

class GetBatteryData extends BatteryEvent {
  const GetBatteryData({this.date});

  final DateTime? date;

  @override
  List<Object?> get props => [date];
}

class ChangeUnit extends BatteryEvent {
  const ChangeUnit(this.unit);

  final int unit;

  @override
  List<Object?> get props => [unit];
}

class StartPolling extends BatteryEvent {
  @override
  List<Object?> get props => [];
}

class StopPolling extends BatteryEvent {
  @override
  List<Object?> get props => [];
}
