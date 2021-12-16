import 'package:clock_app/src/model/alarm.dart';
import 'package:clock_app/src/repository/database/alarm_database.dart';
import 'package:clock_app/src/repository/database/table/alarm_table.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:clock_app/main.dart';

class NotificationRepository {
  final AlarmDatabase _alarmDatabase;

  NotificationRepository(this._alarmDatabase);

  Future<Alarm?> getAlarm(DateTime dateTime) async {
    final record = await _alarmDatabase.getAlarmRecordByDateTime(dateTime);
    return record?.toModel();
  }

  Future<void> _setTimezone() async {
    tz.initializeTimeZones();
    final timezoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneName));
  }

  Future<void> setNotification(Alarm alarm) async {
    final alarmTime = alarm.alarmTime;
    final second = alarmTime.second;
    final time = alarmTime.subtract(Duration(seconds: second));

    await _setTimezone();
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif_1',
      'alarm_notif',
      channelDescription: 'notification_alarm',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('custom_alarm'),
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'custom_alarm.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      alarm.id,
      'Alarm',
      'Body Alarm',
      tz.TZDateTime.from(time, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> removeNotification(Alarm alarm) async {
    await flutterLocalNotificationsPlugin.cancel(alarm.id);
  }
}
