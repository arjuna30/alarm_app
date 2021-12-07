part of 'alarm_bloc.dart';

@immutable
abstract class AlarmEvent {}

class GetCurrentTimeEvent extends AlarmEvent {}

class UpdateHourEvent extends AlarmEvent {
  final DateTime dateTime;

  UpdateHourEvent(this.dateTime);
}
