import 'package:clock_app/src/model/alarm.dart';
import 'package:clock_app/src/repository/database/alarm_database.dart';
import 'package:clock_app/src/repository/database/table/alarm_table.dart';

class AlarmRepository {
  final db = AlarmDatabase();

  Future<List<Alarm>> getAllAlarm() async {
    final alarms = <Alarm>[];
    final records = await db.getAllRecord();
    for (final record in records) {
      alarms.add(record.toModel());
    }
    return alarms;
  }

  Future<Alarm?> getAlarm(int id) async {
    final record = await db.getAlarmRecordById(id);
    return record?.toModel();
  }

  Future<void> insertAlarm(DateTime dateTime) async {
    final alarmRecord = dateTime.toRecordCompanion();
    await db.insertRecord(alarmRecord);
  }

  Future<void> deleteAlarm(Alarm alarm) async {
    final alarmRecord = alarm.toRecord();
    await db.deleteRecord(alarmRecord);
  }

  void toggleIsActive(Alarm alarm) async {
    final alarmRecord = alarm.toRecord();
    await db.updateIsActiveRecord(alarmRecord);
  }
}
