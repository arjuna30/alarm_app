import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm.freezed.dart';

@freezed
class Alarm with _$Alarm {
  const factory Alarm({
    required int id,
    required DateTime alarmTime,
    @Default(true) bool isActive,
  }) = _Alarm;
}
