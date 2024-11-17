import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:green_pal_tracker/graph/data/models/graph_data.dart';
import 'package:green_pal_tracker/graph/data/repository/graph_repository.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';
import 'package:green_pal_tracker/graph/ui/blocs/shared/base_graph_bloc.dart';
import 'package:green_pal_tracker/graph/ui/blocs/shared/base_success_state.dart';

part 'solar_event.dart';
part 'solar_state.dart';

class SolarBloc extends PollingBloc<SolarEvent, SolarState> {
  SolarBloc() : super(const LoadingSolarState()) {
    on<GetSolarData>(_getSolarData);
    on<ChangeUnit>(_changeUnit);
    on<ClearCache>(_clearCache);
    on<StartPolling>((event, emit) => startPolling(() {
          if (state is SuccessSolarState) {
            if (DateUtils.isSameDay((state as SuccessSolarState).date, DateTime.now())) {
              add(const GetSolarData());
            }
          }
        }));
    on<StopPolling>((event, emit) => stopPolling());
  }

  Future<void> _getSolarData(
    GetSolarData event,
    Emitter<SolarState> emit,
  ) async {
    try {
      emit(const LoadingSolarState());
      final response = await _repository.getMonitoringData(GraphType.solar, date: event.date);
      response.fold(
        (l) => emit(ErrorSolarState(message: l.error)),
        (r) => emit(SuccessSolarState(r, EnergyUnit.watt, event.date ?? DateTime.now())),
      );
    } catch (e) {
      emit(ErrorSolarState(message: e.toString()));
    }
  }

  void _changeUnit(
    ChangeUnit event,
    Emitter<SolarState> emit,
  ) {
    emit((state as SuccessSolarState).copyWith(unit: event.unit == 0 ? EnergyUnit.watt : EnergyUnit.kilowatt));
  }

  // clear cache
  void _clearCache(
    ClearCache event,
    Emitter<SolarState> emit,
  ) {
    emit(const LoadingSolarState());
    _repository.clearCache();
    add(const GetSolarData());
  }

  final GraphRepository _repository = GetIt.instance.get<GraphRepository>();
}
