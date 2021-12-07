part of 'clock_bloc.dart';

@immutable
abstract class ClockEvent {}

class GetTimeEvent extends ClockEvent {}

class TimeStartEvent extends ClockEvent {
  final DateTime dateTime;

  TimeStartEvent(this.dateTime);
}
