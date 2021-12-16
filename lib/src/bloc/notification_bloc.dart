import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clock_app/src/model/alarm.dart';
import 'package:clock_app/src/repository/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/main.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;

  static NotificationBloc create(BuildContext context) =>
      NotificationBloc._(injector.get());

  NotificationBloc._(this._notificationRepository)
      : super(NotificationInitial()) {
    on<SetNotificationEvent>(_setNotification);
    on<RemoveNotificationEvent>(_removeNotification);
  }

  Future<void> _setNotification(
      SetNotificationEvent event, Emitter emit) async {
    try {
      final dateTime = event.dateTime;
      final alarm = await _notificationRepository.getAlarm(dateTime);
      await _notificationRepository.setNotification(alarm!);
      emit(NotificationSetState());
    } catch (_) {
      emit(ErrorNotificationSetState());
    }
  }

  Future<void> _removeNotification(
      RemoveNotificationEvent event, Emitter emit) async {
    try {
      final alarm = event.alarm;
      await _notificationRepository.removeNotification(alarm);
      emit(NotificationRemovedState());
    } catch (_) {
      emit(ErrorRemoveNotificationState());
    }
  }
}
