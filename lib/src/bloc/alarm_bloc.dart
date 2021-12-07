import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  static AlarmBloc create(BuildContext context) =>
      AlarmBloc()..add(GetCurrentTimeEvent());

  AlarmBloc() : super(AlarmInitial()) {
    on<GetCurrentTimeEvent>(_getTime);
    on<UpdateHourEvent>(_updateHour);
  }

  Future<void> _getTime(GetCurrentTimeEvent event, Emitter emit) async {
    final dateTime = DateTime.now();
    emit(TimeState(dateTime));
  }

  Future<void> _updateHour(UpdateHourEvent event, Emitter emit) async {
    emit(TimeState(event.dateTime));
  }
}
