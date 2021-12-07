part of 'set_alarm_bloc.dart';

@immutable
abstract class SetAlarmEvent {}

class GetAlarmEvent extends SetAlarmEvent {}

class AddAlarmEvent extends SetAlarmEvent {
  final DateTime dateTime;

  AddAlarmEvent(this.dateTime);
}

class DeleteAlarmEvent extends SetAlarmEvent {
  final Alarm alarm;

  DeleteAlarmEvent(this.alarm);
}

class ToggleIsActiveEvent extends SetAlarmEvent {
  final Alarm alarm;

  ToggleIsActiveEvent(this.alarm);
}
