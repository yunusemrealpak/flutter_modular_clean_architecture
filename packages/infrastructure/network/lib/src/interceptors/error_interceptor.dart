import 'package:dio/dio.dart';
import '../exceptions/network_exception.dart';

/// Interceptor for handling and transforming errors into custom exceptions
class ErrorInterceptor extends Interceptor {
  /// Callback for custom error handling
  final void Function(NetworkException exception)? onErrorCallback;

  ErrorInterceptor({this.onErrorCallback});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _handleError(err);

    // Call custom error handler if provided
    onErrorCallback?.call(exception);

    // Create a new DioException with the custom exception
    final newError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: exception,
      message: exception.message,
    );

    handler.next(newError);
  }

  /// Transforms DioException into custom NetworkException
  NetworkException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);

      case DioExceptionType.cancel:
        return const CancelException();

      case DioExceptionType.connectionError:
        return const NoInternetException();

      case DioExceptionType.badCertificate:
        return const UnknownException(message: 'Bad certificate');

      case DioExceptionType.unknown:
        if (error.error != null && error.error.toString().contains('SocketException')) {
          return const NoInternetException();
        }
        return UnknownException(message: error.message);
    }
  }

  /// Handles HTTP response errors based on status code
  NetworkException _handleResponseError(Response? response) {
    if (response == null) {
      return const UnknownException();
    }

    final statusCode = response.statusCode ?? 0;
    final message = _extractErrorMessage(response.data);

    switch (statusCode) {
      case 400:
        return BadRequestException(message: message);
      case 401:
        return UnauthorizedException(message: message);
      case 403:
        return ForbiddenException(message: message);
      case 404:
        return NotFoundException(message: message);
      case 409:
        return ConflictException(message: message);
      case 500:
        return InternalServerException(message: message);
      case 503:
        return ServiceUnavailableException(message: message);
      default:
        return UnknownException(message: message ?? 'HTTP $statusCode error');
    }
  }

  /// Extracts error message from response data
  String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map) {
      // Try common error message fields
      return data['message'] as String? ??
          data['error'] as String? ??
          data['errorMessage'] as String? ??
          data['msg'] as String?;
    }

    if (data is String) {
      return data;
    }

    return null;
  }
}
