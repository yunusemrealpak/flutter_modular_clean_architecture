import 'dart:async';
import 'package:dio/dio.dart';

/// Interceptor for retrying failed requests
class RetryInterceptor extends Interceptor {
  /// Maximum number of retry attempts
  final int maxRetries;

  /// Delay between retry attempts
  final Duration retryDelay;

  /// List of status codes that should trigger a retry
  final List<int> retryableStatusCodes;

  /// Callback to determine if a request should be retried
  final bool Function(DioException error)? shouldRetry;

  RetryInterceptor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.retryableStatusCodes = const [408, 429, 500, 502, 503, 504],
    this.shouldRetry,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Get retry count from request options
    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;

    // Check if we should retry
    if (!_shouldRetryRequest(err, retryCount)) {
      return handler.next(err);
    }

    // Increment retry count
    err.requestOptions.extra['retryCount'] = retryCount + 1;

    // Wait before retrying
    await Future.delayed(_calculateDelay(retryCount));

    try {
      // Retry the request
      final response = await Dio().fetch(err.requestOptions);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  /// Determines if the request should be retried
  bool _shouldRetryRequest(DioException error, int retryCount) {
    // Check if we've exceeded max retries
    if (retryCount >= maxRetries) {
      return false;
    }

    // Use custom shouldRetry callback if provided
    if (shouldRetry != null) {
      return shouldRetry!(error);
    }

    // Check if the error type is retryable
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return true;
    }

    // Check if the status code is retryable
    if (error.response?.statusCode != null) {
      return retryableStatusCodes.contains(error.response!.statusCode);
    }

    return false;
  }

  /// Calculates the delay before the next retry using exponential backoff
  Duration _calculateDelay(int retryCount) {
    return retryDelay * (retryCount + 1);
  }
}
