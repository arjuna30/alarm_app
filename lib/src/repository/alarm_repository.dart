import 'package:clock_app/src/model/alarm.dart';
import 'package:clock_app/src/repository/database/alarm_database.dart';
import 'package:clock_app/src/repository/database/table/alarm_table.dart';

class AlarmRepository {
  final AlarmDatabase _alarmDatabase;

  AlarmRepository(this._alarmDatabase);

  Future<List<Alarm>> getAllAlarm() async {
    final alarms = <Alarm>[];
    final records = await _alarmDatabase.getAllRecord();
    for (final record in records) {
      alarms.add(record.toModel());
    }
    return alarms;
  }

  Future<Alarm?> getAlarm(int id) async {
    final record = await _alarmDatabase.getAlarmRecordById(id);
    return record?.toModel();
  }

  Future<void> insertAlarm(DateTime dateTime) async {
    final alarmRecord = dateTime.toRecordCompanion();
    await _alarmDatabase.insertRecord(alarmRecord);
  }

  Future<void> deleteAlarm(Alarm alarm) async {
    final alarmRecord = alarm.toRecord();
    await _alarmDatabase.deleteRecord(alarmRecord);
  }

  Future<void> toggleIsActive(Alarm alarm) async {
    final alarmRecord = alarm.toRecord();
    await _alarmDatabase.updateIsActiveRecord(alarmRecord);
  }
}
