// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AlarmRecord extends DataClass implements Insertable<AlarmRecord> {
  final int id;
  final DateTime alarmTime;
  final bool isActive;
  AlarmRecord(
      {required this.id, required this.alarmTime, required this.isActive});
  factory AlarmRecord.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AlarmRecord(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      alarmTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}alarm_time'])!,
      isActive: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_active'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['alarm_time'] = Variable<DateTime>(alarmTime);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  AlarmTableCompanion toCompanion(bool nullToAbsent) {
    return AlarmTableCompanion(
      id: Value(id),
      alarmTime: Value(alarmTime),
      isActive: Value(isActive),
    );
  }

  factory AlarmRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AlarmRecord(
      id: serializer.fromJson<int>(json['id']),
      alarmTime: serializer.fromJson<DateTime>(json['alarmTime']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'alarmTime': serializer.toJson<DateTime>(alarmTime),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  AlarmRecord copyWith({int? id, DateTime? alarmTime, bool? isActive}) =>
      AlarmRecord(
        id: id ?? this.id,
        alarmTime: alarmTime ?? this.alarmTime,
        isActive: isActive ?? this.isActive,
      );
  @override
  String toString() {
    return (StringBuffer('AlarmRecord(')
          ..write('id: $id, ')
          ..write('alarmTime: $alarmTime, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, alarmTime, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmRecord &&
          other.id == this.id &&
          other.alarmTime == this.alarmTime &&
          other.isActive == this.isActive);
}

class AlarmTableCompanion extends UpdateCompanion<AlarmRecord> {
  final Value<int> id;
  final Value<DateTime> alarmTime;
  final Value<bool> isActive;
  const AlarmTableCompanion({
    this.id = const Value.absent(),
    this.alarmTime = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  AlarmTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime alarmTime,
    this.isActive = const Value.absent(),
  }) : alarmTime = Value(alarmTime);
  static Insertable<AlarmRecord> custom({
    Expression<int>? id,
    Expression<DateTime>? alarmTime,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (alarmTime != null) 'alarm_time': alarmTime,
      if (isActive != null) 'is_active': isActive,
    });
  }

  AlarmTableCompanion copyWith(
      {Value<int>? id, Value<DateTime>? alarmTime, Value<bool>? isActive}) {
    return AlarmTableCompanion(
      id: id ?? this.id,
      alarmTime: alarmTime ?? this.alarmTime,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (alarmTime.present) {
      map['alarm_time'] = Variable<DateTime>(alarmTime.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmTableCompanion(')
          ..write('id: $id, ')
          ..write('alarmTime: $alarmTime, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $AlarmTableTable extends AlarmTable
    with TableInfo<$AlarmTableTable, AlarmRecord> {
  final GeneratedDatabase _db;
  final String? _alias;
  $AlarmTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _alarmTimeMeta = const VerificationMeta('alarmTime');
  late final GeneratedColumn<DateTime?> alarmTime = GeneratedColumn<DateTime?>(
      'alarm_time', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _isActiveMeta = const VerificationMeta('isActive');
  late final GeneratedColumn<bool?> isActive = GeneratedColumn<bool?>(
      'is_active', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_active IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, alarmTime, isActive];
  @override
  String get aliasedName => _alias ?? 'alarm_table';
  @override
  String get actualTableName => 'alarm_table';
  @override
  VerificationContext validateIntegrity(Insertable<AlarmRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('alarm_time')) {
      context.handle(_alarmTimeMeta,
          alarmTime.isAcceptableOrUnknown(data['alarm_time']!, _alarmTimeMeta));
    } else if (isInserting) {
      context.missing(_alarmTimeMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlarmRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AlarmRecord.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AlarmTableTable createAlias(String alias) {
    return $AlarmTableTable(_db, alias);
  }
}

abstract class _$AlarmDatabase extends GeneratedDatabase {
  _$AlarmDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AlarmTableTable alarmTable = $AlarmTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [alarmTable];
}
