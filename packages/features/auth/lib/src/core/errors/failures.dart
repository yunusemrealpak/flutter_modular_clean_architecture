import 'package:equatable/equatable.dart';

/// Base class for all failures
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'ServerFailure(message: $message, code: $code)';
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'NetworkFailure(message: $message, code: $code)';
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'CacheFailure(message: $message, code: $code)';
}

/// Validation failure
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'ValidationFailure(message: $message, code: $code)';
}

/// Authentication failure
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'AuthFailure(message: $message, code: $code)';
}

/// Unauthorized failure
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Unauthorized access',
    super.code = 'UNAUTHORIZED',
  });

  @override
  String toString() => 'UnauthorizedFailure(message: $message, code: $code)';
}
