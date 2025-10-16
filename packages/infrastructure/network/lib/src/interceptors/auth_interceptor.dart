import 'package:dio/dio.dart';

/// Interceptor for handling authentication
/// Adds authentication token to requests and handles token refresh
class AuthInterceptor extends Interceptor {
  /// Callback to get the current access token
  final Future<String?> Function() getAccessToken;

  /// Callback to refresh the access token
  final Future<String?> Function()? onTokenRefresh;

  /// Callback when token refresh fails (e.g., logout user)
  final Future<void> Function()? onTokenRefreshFailed;

  /// Header name for the authorization token
  final String authHeaderKey;

  /// Token type prefix (e.g., 'Bearer')
  final String tokenType;

  AuthInterceptor({
    required this.getAccessToken,
    this.onTokenRefresh,
    this.onTokenRefreshFailed,
    this.authHeaderKey = 'Authorization',
    this.tokenType = 'Bearer',
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip adding token if the request already has authorization header
    if (options.headers.containsKey(authHeaderKey)) {
      return handler.next(options);
    }

    // Get the access token
    final token = await getAccessToken();

    // Add token to headers if available
    if (token != null && token.isNotEmpty) {
      options.headers[authHeaderKey] = '$tokenType $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized errors
    if (err.response?.statusCode == 401 && onTokenRefresh != null) {
      try {
        // Try to refresh the token
        final newToken = await onTokenRefresh!();

        if (newToken != null && newToken.isNotEmpty) {
          // Update the request with the new token
          err.requestOptions.headers[authHeaderKey] = '$tokenType $newToken';

          // Retry the request
          final opts = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          );

          final response = await Dio().request(
            err.requestOptions.path,
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );

          return handler.resolve(response);
        } else {
          // Token refresh failed
          await onTokenRefreshFailed?.call();
        }
      } catch (e) {
        // Token refresh failed
        await onTokenRefreshFailed?.call();
      }
    }

    handler.next(err);
  }
}
