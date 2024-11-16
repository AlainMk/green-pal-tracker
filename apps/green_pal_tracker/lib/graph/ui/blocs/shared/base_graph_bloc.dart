import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PollingBloc<Event, State> extends Bloc<Event, State> {
  PollingBloc(super.initialState);

  Timer? _pollingTimer;

  void startPolling(void Function() onPoll, {Duration interval = const Duration(seconds: 15)}) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(interval, (_) => onPoll());
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
