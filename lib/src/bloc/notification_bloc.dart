import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clock_app/src/model/alarm.dart';
import 'package:clock_app/src/repository/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  static NotificationBloc create(BuildContext context) => NotificationBloc();

  final _notificationRepository = NotificationRepository();

  NotificationBloc() : super(NotificationInitial()) {
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
