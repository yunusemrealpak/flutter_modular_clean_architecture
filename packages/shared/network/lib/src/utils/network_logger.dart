import 'dart:developer' as developer;

/// Logger utility for network operations
class NetworkLogger {
  final String _tag;
  final bool _enabled;

  const NetworkLogger({
    String tag = 'Network',
    bool enabled = true,
  })  : _tag = tag,
        _enabled = enabled;

  /// Logs a debug message
  void debug(String message) {
    if (!_enabled) return;
    developer.log(
      message,
      name: _tag,
      level: 500, // Debug level
    );
  }

  /// Logs an info message
  void info(String message) {
    if (!_enabled) return;
    developer.log(
      message,
      name: _tag,
      level: 800, // Info level
    );
  }

  /// Logs a warning message
  void warning(String message) {
    if (!_enabled) return;
    developer.log(
      message,
      name: _tag,
      level: 900, // Warning level
    );
  }

  /// Logs an error message
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (!_enabled) return;
    developer.log(
      message,
      name: _tag,
      level: 1000, // Error level
      error: error,
      stackTrace: stackTrace,
    );
  }
}
