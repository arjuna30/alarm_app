part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationSetState extends NotificationState {}

class ErrorNotificationSetState extends NotificationState {}

class NotificationRemovedState extends NotificationState {}

class ErrorRemoveNotificationState extends NotificationState {}
