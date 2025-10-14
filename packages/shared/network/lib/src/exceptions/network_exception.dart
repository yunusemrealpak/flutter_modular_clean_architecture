/// Base class for all network-related exceptions
abstract class NetworkException implements Exception {
  /// The error message
  final String message;

  /// The error code (if available)
  final String? code;

  /// The status code from the HTTP response
  final int? statusCode;

  const NetworkException({
    required this.message,
    this.code,
    this.statusCode,
  });

  @override
  String toString() => 'NetworkException: $message (code: $code, status: $statusCode)';
}

/// Exception thrown when there's no internet connection
class NoInternetException extends NetworkException {
  const NoInternetException()
      : super(
          message: 'No internet connection available',
          code: 'NO_INTERNET',
        );

  @override
  String toString() => 'NoInternetException: $message';
}

/// Exception thrown when the request times out
class TimeoutException extends NetworkException {
  const TimeoutException()
      : super(
          message: 'Request timeout',
          code: 'TIMEOUT',
        );

  @override
  String toString() => 'TimeoutException: $message';
}

/// Exception thrown for bad request (400)
class BadRequestException extends NetworkException {
  const BadRequestException({String? message})
      : super(
          message: message ?? 'Bad request',
          code: 'BAD_REQUEST',
          statusCode: 400,
        );

  @override
  String toString() => 'BadRequestException: $message';
}

/// Exception thrown when authentication fails (401)
class UnauthorizedException extends NetworkException {
  const UnauthorizedException({String? message})
      : super(
          message: message ?? 'Unauthorized',
          code: 'UNAUTHORIZED',
          statusCode: 401,
        );

  @override
  String toString() => 'UnauthorizedException: $message';
}

/// Exception thrown when access is forbidden (403)
class ForbiddenException extends NetworkException {
  const ForbiddenException({String? message})
      : super(
          message: message ?? 'Forbidden',
          code: 'FORBIDDEN',
          statusCode: 403,
        );

  @override
  String toString() => 'ForbiddenException: $message';
}

/// Exception thrown when resource is not found (404)
class NotFoundException extends NetworkException {
  const NotFoundException({String? message})
      : super(
          message: message ?? 'Resource not found',
          code: 'NOT_FOUND',
          statusCode: 404,
        );

  @override
  String toString() => 'NotFoundException: $message';
}

/// Exception thrown for conflict errors (409)
class ConflictException extends NetworkException {
  const ConflictException({String? message})
      : super(
          message: message ?? 'Conflict',
          code: 'CONFLICT',
          statusCode: 409,
        );

  @override
  String toString() => 'ConflictException: $message';
}

/// Exception thrown for internal server errors (500)
class InternalServerException extends NetworkException {
  const InternalServerException({String? message})
      : super(
          message: message ?? 'Internal server error',
          code: 'INTERNAL_SERVER_ERROR',
          statusCode: 500,
        );

  @override
  String toString() => 'InternalServerException: $message';
}

/// Exception thrown for service unavailable errors (503)
class ServiceUnavailableException extends NetworkException {
  const ServiceUnavailableException({String? message})
      : super(
          message: message ?? 'Service unavailable',
          code: 'SERVICE_UNAVAILABLE',
          statusCode: 503,
        );

  @override
  String toString() => 'ServiceUnavailableException: $message';
}

/// Exception thrown for unknown errors
class UnknownException extends NetworkException {
  const UnknownException({String? message})
      : super(
          message: message ?? 'An unknown error occurred',
          code: 'UNKNOWN',
        );

  @override
  String toString() => 'UnknownException: $message';
}

/// Exception thrown when request is cancelled
class CancelException extends NetworkException {
  const CancelException()
      : super(
          message: 'Request was cancelled',
          code: 'CANCELLED',
        );

  @override
  String toString() => 'CancelException: $message';
}

/// Exception thrown when there's a parsing error
class ParseException extends NetworkException {
  const ParseException({String? message})
      : super(
          message: message ?? 'Failed to parse response',
          code: 'PARSE_ERROR',
        );

  @override
  String toString() => 'ParseException: $message';
}
