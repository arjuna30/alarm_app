part of 'clock_bloc.dart';

@immutable
abstract class ClockState {}

class ClockInitial extends ClockState {}

class GetTimeSuccessState extends ClockState {}

class CurrentTimeState extends ClockState {
  final DateTime dateTime;

  CurrentTimeState(this.dateTime);
}

class ErrorTimeState extends ClockState {}
