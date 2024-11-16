import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:green_pal_tracker/graph/data/models/graph_data.dart';
import 'package:green_pal_tracker/graph/data/repository/graph_repository.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';
import 'package:green_pal_tracker/graph/ui/blocs/shared/base_graph_bloc.dart';
import 'package:green_pal_tracker/graph/ui/blocs/shared/base_success_state.dart';

part 'house_event.dart';
part 'house_state.dart';

class HouseBloc extends PollingBloc<HouseEvent, HouseState> {
  HouseBloc() : super(const LoadingHouseState()) {
    on<GetHouseData>(_getHouseData);
    on<ChangeUnit>(_changeUnit);
    on<StartPolling>((event, emit) => startPolling(() {
          if (state is SuccessHouseState) {
            if (DateUtils.isSameDay((state as SuccessHouseState).date, DateTime.now())) {
              add(const GetHouseData());
            }
          }
        }));
    on<StopPolling>((event, emit) => stopPolling());
  }

  Future<void> _getHouseData(
    GetHouseData event,
    Emitter<HouseState> emit,
  ) async {
    try {
      emit(const LoadingHouseState());
      final response = await _repository.getMonitoringData(GraphType.house, date: event.date);
      response.fold(
        (l) => emit(ErrorHouseState(message: l.error)),
        (r) => emit(SuccessHouseState(r, EnergyUnit.watt, event.date ?? DateTime.now())),
      );
    } catch (e) {
      emit(ErrorHouseState(message: e.toString()));
    }
  }

  void _changeUnit(
    ChangeUnit event,
    Emitter<HouseState> emit,
  ) {
    emit((state as SuccessHouseState).copyWith(unit: event.unit == 0 ? EnergyUnit.watt : EnergyUnit.kilowatt));
  }

  final GraphRepository _repository = GetIt.instance.get<GraphRepository>();
}
