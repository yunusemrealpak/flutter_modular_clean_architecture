import 'package:dio/dio.dart';

/// Configuration for HTTP client
class HttpClientConfig {
  /// Base URL for API requests
  final String baseUrl;

  /// Connection timeout duration
  final Duration connectTimeout;

  /// Receive timeout duration
  final Duration receiveTimeout;

  /// Send timeout duration
  final Duration sendTimeout;

  /// Default headers to include in all requests
  final Map<String, dynamic>? headers;

  /// Query parameters to include in all requests
  final Map<String, dynamic>? queryParameters;

  /// Whether to follow redirects
  final bool followRedirects;

  /// Maximum number of redirects to follow
  final int maxRedirects;

  /// Response type
  final ResponseType responseType;

  /// Validate status codes
  final ValidateStatus? validateStatus;

  /// Enable logging
  final bool enableLogging;

  /// Enable retry mechanism
  final bool enableRetry;

  /// Maximum number of retry attempts
  final int maxRetries;

  /// Delay between retry attempts
  final Duration retryDelay;

  /// Enable connectivity check before requests
  final bool enableConnectivityCheck;

  const HttpClientConfig({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
    this.headers,
    this.queryParameters,
    this.followRedirects = true,
    this.maxRedirects = 5,
    this.responseType = ResponseType.json,
    this.validateStatus,
    this.enableLogging = true,
    this.enableRetry = true,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.enableConnectivityCheck = true,
  });

  /// Creates a copy with modified fields
  HttpClientConfig copyWith({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool? followRedirects,
    int? maxRedirects,
    ResponseType? responseType,
    ValidateStatus? validateStatus,
    bool? enableLogging,
    bool? enableRetry,
    int? maxRetries,
    Duration? retryDelay,
    bool? enableConnectivityCheck,
  }) {
    return HttpClientConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      headers: headers ?? this.headers,
      queryParameters: queryParameters ?? this.queryParameters,
      followRedirects: followRedirects ?? this.followRedirects,
      maxRedirects: maxRedirects ?? this.maxRedirects,
      responseType: responseType ?? this.responseType,
      validateStatus: validateStatus ?? this.validateStatus,
      enableLogging: enableLogging ?? this.enableLogging,
      enableRetry: enableRetry ?? this.enableRetry,
      maxRetries: maxRetries ?? this.maxRetries,
      retryDelay: retryDelay ?? this.retryDelay,
      enableConnectivityCheck: enableConnectivityCheck ?? this.enableConnectivityCheck,
    );
  }
}
