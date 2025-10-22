import 'package:equatable/equatable.dart';

/// Base class for all failures in the product feature
abstract class Failure extends Equatable {
  /// Error message
  final String message;

  /// Optional error code
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Server error failure
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

/// Network connection failure
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

/// Cache/Local storage failure
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Input validation failure
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

/// Feature-specific failure
class ProductFailure extends Failure {
  const ProductFailure({required super.message, super.code});
}

/// Unauthorized access failure
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message, super.code});
}
