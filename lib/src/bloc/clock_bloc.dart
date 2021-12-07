import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'clock_event.dart';
part 'clock_state.dart';

// Bloc for streaming current date time
class ClockBloc extends Bloc<ClockEvent, ClockState> {
  static ClockBloc create(BuildContext context) =>
      ClockBloc()..add(GetTimeEvent());

  ClockBloc() : super(ClockInitial()) {
    on<GetTimeEvent>(_onGetTimeEvent);
    on<TimeStartEvent>(_onTimeStartEvent);
  }

  Stream<DateTime> _getTime() {
    return Stream.periodic(
        const Duration(milliseconds: 500), (value) => DateTime.now());
  }

  Future<void> _onGetTimeEvent(GetTimeEvent event, Emitter emit) async {
    try {
      await emit.onEach<DateTime>(
        _getTime(),
        onData: (data) => add(TimeStartEvent(data)),
      );
      emit(GetTimeSuccessState());
    } catch (_) {
      emit(ErrorTimeState());
    }
  }

  Future<void> _onTimeStartEvent(TimeStartEvent event, Emitter emit) async {
    try {
      emit(CurrentTimeState(event.dateTime));
    } catch (_) {
      emit(ErrorTimeState());
    }
  }
}
