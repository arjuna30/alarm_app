import 'package:clock_app/src/repository/database/table/alarm_table.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'alarm_database.g.dart';

@UseMoor(tables: [AlarmTable])
class AlarmDatabase extends _$AlarmDatabase {
  AlarmDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true)));

  @override
  int get schemaVersion => 1;

  Future<List<AlarmRecord>> getAllRecord() async =>
      await select(alarmTable).get();

  Future<AlarmRecord?> getAlarmRecordById(int id) async =>
      await (select(alarmTable)..where((tbl) => tbl.id.equals(id)))
          .getSingleOrNull();

  Future<AlarmRecord?> getAlarmRecordByDateTime(DateTime dateTime) async =>
      await (select(alarmTable)..where((tbl) => tbl.alarmTime.equals(dateTime)))
          .getSingleOrNull();

  Future<void> insertRecord(AlarmTableCompanion alarmRecord) async =>
      await into(alarmTable).insert(alarmRecord);

  Future<void> deleteRecord(AlarmRecord alarmRecord) async =>
      await delete(alarmTable).delete(alarmRecord);

  Future<void> updateIsActiveRecord(AlarmRecord alarmRecord) async =>
      update(alarmTable)
        ..where((tbl) => tbl.id.equals(alarmRecord.id))
        ..write(AlarmTableCompanion(isActive: Value(!alarmRecord.isActive)));
}
