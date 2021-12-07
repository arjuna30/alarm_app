import 'package:bloc/bloc.dart';
import 'package:clock_app/src/model/alarm.dart';
import 'package:clock_app/src/repository/alarm_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'set_alarm_event.dart';
part 'set_alarm_state.dart';

class SetAlarmBloc extends Bloc<SetAlarmEvent, SetAlarmState> {
  static SetAlarmBloc create(BuildContext context) =>
      SetAlarmBloc()..add(GetAlarmEvent());

  final _alarmRepository = AlarmRepository();

  SetAlarmBloc() : super(SetAlarmInitial()) {
    on<GetAlarmEvent>(_getSavedAlarm);
    on<AddAlarmEvent>(_addAlarm);
    on<DeleteAlarmEvent>(_deleteAlarm);
    on<ToggleIsActiveEvent>(_toggleIsActive);
  }

  Future<void> _getSavedAlarm(GetAlarmEvent event, Emitter emit) async {
    try {
      final alarms = await _alarmRepository.getAllAlarm();
      emit(SuccessGetAlarmState(alarms));
    } catch (e) {
      emit(ErrorSetAlarmState());
    }
  }

  Future<void> _addAlarm(AddAlarmEvent event, Emitter emit) async {
    try {
      final dateTime = event.dateTime;
      await _alarmRepository.insertAlarm(dateTime);
      emit(SuccessSetAlarmState());

      final alarms = await _alarmRepository.getAllAlarm();
      emit(SuccessGetAlarmState(alarms));
    } catch (e) {
      emit(ErrorSetAlarmState());
    }
  }

  Future<void> _deleteAlarm(DeleteAlarmEvent event, Emitter emit) async {
    try {
      final alarm = event.alarm;
      await _alarmRepository.deleteAlarm(alarm);

      final alarms = await _alarmRepository.getAllAlarm();
      emit(SuccessGetAlarmState(alarms));
    } catch (e) {
      emit(ErrorSetAlarmState());
    }
  }

  Future<void> _toggleIsActive(ToggleIsActiveEvent event, Emitter emit) async {
    try {
      final alarm = event.alarm;
      _alarmRepository.toggleIsActive(alarm);

      final alarms = await _alarmRepository.getAllAlarm();
      emit(SuccessGetAlarmState(alarms));
    } catch (_) {
      emit(ErrorSetAlarmState());
    }
  }
}
