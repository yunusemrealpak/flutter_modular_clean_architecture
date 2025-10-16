import 'package:flutter/foundation.dart';

/// Base class for all events in the system
/// Events are immutable and represent something that has happened
@immutable
abstract class BaseEvent {
  /// Event name/type for identification
  String get eventName;

  /// Event payload (optional)
  Map<String, dynamic>? get payload => null;

  /// Timestamp when event was created
  final DateTime timestamp;

  const BaseEvent() : timestamp = const _ConstDateTime();

  @override
  String toString() {
    return '$eventName(timestamp: $timestamp, payload: $payload)';
  }
}

/// Helper class for const timestamp
class _ConstDateTime implements DateTime {
  const _ConstDateTime();

  @override
  DateTime add(Duration duration) => DateTime.now().add(duration);

  @override
  int compareTo(DateTime other) => DateTime.now().compareTo(other);

  @override
  DateTime subtract(Duration duration) => DateTime.now().subtract(duration);

  @override
  Duration difference(DateTime other) => DateTime.now().difference(other);

  @override
  bool isAfter(DateTime other) => DateTime.now().isAfter(other);

  @override
  bool isAtSameMomentAs(DateTime other) =>
      DateTime.now().isAtSameMomentAs(other);

  @override
  bool isBefore(DateTime other) => DateTime.now().isBefore(other);

  @override
  DateTime toLocal() => DateTime.now().toLocal();

  @override
  DateTime toUtc() => DateTime.now().toUtc();

  @override
  String toIso8601String() => DateTime.now().toIso8601String();

  @override
  int get day => DateTime.now().day;

  @override
  int get hour => DateTime.now().hour;

  @override
  bool get isUtc => DateTime.now().isUtc;

  @override
  int get microsecond => DateTime.now().microsecond;

  @override
  int get microsecondsSinceEpoch => DateTime.now().microsecondsSinceEpoch;

  @override
  int get millisecond => DateTime.now().millisecond;

  @override
  int get millisecondsSinceEpoch => DateTime.now().millisecondsSinceEpoch;

  @override
  int get minute => DateTime.now().minute;

  @override
  int get month => DateTime.now().month;

  @override
  int get second => DateTime.now().second;

  @override
  String get timeZoneName => DateTime.now().timeZoneName;

  @override
  Duration get timeZoneOffset => DateTime.now().timeZoneOffset;

  @override
  int get weekday => DateTime.now().weekday;

  @override
  int get year => DateTime.now().year;
}
