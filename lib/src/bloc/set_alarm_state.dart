part of 'set_alarm_bloc.dart';

@immutable
abstract class SetAlarmState {}

class SetAlarmInitial extends SetAlarmState {}

class SuccessSetAlarmState extends SetAlarmState {}

class SuccessGetAlarmState extends SetAlarmState {
  final List<Alarm> alarms;
  SuccessGetAlarmState(this.alarms);
}

class SuccessDeleteAlarmState extends SetAlarmState {}

class ErrorSetAlarmState extends SetAlarmState {}
