part of 'alarm_bloc.dart';

@immutable
abstract class AlarmState {}

class AlarmInitial extends AlarmState {}

class TimeState extends AlarmState {
  final DateTime dateTime;

  TimeState(this.dateTime);
}

class UpdatedTimeState extends AlarmState {
  final DateTime dateTime;

  UpdatedTimeState(this.dateTime);
}
