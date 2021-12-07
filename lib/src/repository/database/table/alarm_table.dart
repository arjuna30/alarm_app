import 'package:clock_app/src/model/alarm.dart';
import 'package:clock_app/src/repository/database/alarm_database.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

@DataClassName('AlarmRecord')
class AlarmTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get alarmTime => dateTime()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

extension DateTimeToAlarmTable on DateTime {
  AlarmTableCompanion toRecordCompanion() =>
      AlarmTableCompanion(alarmTime: Value(this));
}

extension AlarmRevordMapper on AlarmRecord {
  Alarm toModel() => Alarm(id: id, alarmTime: alarmTime, isActive: isActive);
}

extension AlarmMapper on Alarm {
  AlarmRecord toRecord() =>
      AlarmRecord(id: id, alarmTime: alarmTime, isActive: isActive);
}
