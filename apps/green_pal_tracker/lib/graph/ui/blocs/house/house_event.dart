part of 'house_bloc.dart';

sealed class HouseEvent extends Equatable {
  const HouseEvent();
}

class GetHouseData extends HouseEvent {
  const GetHouseData({this.date});

  final DateTime? date;

  @override
  List<Object?> get props => [date];
}

class ChangeUnit extends HouseEvent {
  const ChangeUnit(this.unit);

  final int unit;

  @override
  List<Object?> get props => [unit];
}

class StartPolling extends HouseEvent {
  @override
  List<Object?> get props => [];
}

class StopPolling extends HouseEvent {
  @override
  List<Object?> get props => [];
}
