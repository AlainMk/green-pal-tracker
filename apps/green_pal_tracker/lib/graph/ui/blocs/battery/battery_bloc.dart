import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:green_pal_tracker/graph/data/models/graph_data.dart';
import 'package:green_pal_tracker/graph/data/repository/graph_repository.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';
import 'package:green_pal_tracker/graph/ui/blocs/shared/success_base_state.dart';

part 'battery_event.dart';
part 'battery_state.dart';

class BatteryBloc extends Bloc<BatteryEvent, BatteryState> {
  BatteryBloc() : super(const LoadingBatteryState()) {
    on<GetBatteryData>(_getBatteryData);
    on<ChangeUnit>(_changeUnit);
  }

  Future<void> _getBatteryData(
    GetBatteryData event,
    Emitter<BatteryState> emit,
  ) async {
    try {
      emit(const LoadingBatteryState());
      final response = await _repository.getMonitoringData(GraphType.battery, date: event.date);
      response.fold(
        (l) => emit(ErrorBatteryState(message: l.error)),
        (r) => emit(SuccessBatteryState(r, EnergyUnit.watt, event.date ?? DateTime.now())),
      );
    } catch (e) {
      emit(ErrorBatteryState(message: e.toString()));
    }
  }

  void _changeUnit(
    ChangeUnit event,
    Emitter<BatteryState> emit,
  ) {
    emit((state as SuccessBatteryState).copyWith(unit: event.unit == 0 ? EnergyUnit.watt : EnergyUnit.kilowatt));
  }

  final GraphRepository _repository = GetIt.instance.get<GraphRepository>();
}
