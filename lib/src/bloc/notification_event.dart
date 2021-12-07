part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class SetNotificationEvent extends NotificationEvent {
  final DateTime dateTime;
  SetNotificationEvent(this.dateTime);
}

class RemoveNotificationEvent extends NotificationEvent {
  final Alarm alarm;
  RemoveNotificationEvent(this.alarm);
}
