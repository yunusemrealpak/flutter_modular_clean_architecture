import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../connectivity/network_info.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/connectivity_interceptor.dart';
import '../interceptors/error_interceptor.dart';
import '../interceptors/retry_interceptor.dart';
import 'http_client_config.dart';

/// Professional HTTP client wrapper around Dio
class HttpClient {
  late final Dio _dio;
  final HttpClientConfig _config;
  final NetworkInfo? _networkInfo;

  HttpClient({
    required HttpClientConfig config,
    NetworkInfo? networkInfo,
    Dio? dio,
  }) : _config = config,
       _networkInfo = networkInfo {
    _dio = dio ?? Dio();
    _configureDio();
  }

  /// Get the underlying Dio instance
  Dio get dio => _dio;

  /// Get the current configuration
  HttpClientConfig get config => _config;

  /// Configure Dio with options and interceptors
  void _configureDio() {
    // Set base options
    _dio.options = BaseOptions(
      baseUrl: _config.baseUrl,
      connectTimeout: _config.connectTimeout,
      receiveTimeout: _config.receiveTimeout,
      sendTimeout: _config.sendTimeout,
      headers: _config.headers,
      queryParameters: _config.queryParameters,
      followRedirects: _config.followRedirects,
      maxRedirects: _config.maxRedirects,
      responseType: _config.responseType,
      validateStatus: _config.validateStatus,
    );

    // Clear existing interceptors
    _dio.interceptors.clear();

    // Add connectivity interceptor if enabled
    if (_config.enableConnectivityCheck && _networkInfo != null) {
      _dio.interceptors.add(ConnectivityInterceptor(_networkInfo));
    }

    // Add retry interceptor if enabled
    if (_config.enableRetry) {
      _dio.interceptors.add(
        RetryInterceptor(
          maxRetries: _config.maxRetries,
          retryDelay: _config.retryDelay,
        ),
      );
    }

    // Add error interceptor
    _dio.interceptors.add(ErrorInterceptor());

    // Add logging interceptor if enabled
    if (_config.enableLogging) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  /// Add a custom interceptor
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// Add header to requests
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  /// Add auth interceptor
  void addAuthInterceptor({
    required Future<String?> Function() getAccessToken,
    Future<String?> Function()? onTokenRefresh,
    Future<void> Function()? onTokenRefreshFailed,
    String authHeaderKey = 'Authorization',
    String tokenType = 'Bearer',
  }) {
    // Remove existing auth interceptor if any
    _dio.interceptors.removeWhere((i) => i is AuthInterceptor);

    // Add new auth interceptor at the beginning
    _dio.interceptors.insert(
      0,
      AuthInterceptor(
        getAccessToken: getAccessToken,
        onTokenRefresh: onTokenRefresh,
        onTokenRefreshFailed: onTokenRefreshFailed,
        authHeaderKey: authHeaderKey,
        tokenType: tokenType,
      ),
    );
  }

  /// Performs a GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Performs a POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Performs a PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Performs a PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Performs a DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Downloads a file
  Future<Response> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    dynamic data,
    Options? options,
  }) {
    return _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    );
  }

  /// Uploads a file with multipart/form-data
  Future<Response<T>> upload<T>(
    String path, {
    required FormData data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Creates a FormData object for file uploads
  static FormData createFormData(Map<String, dynamic> fields) {
    return FormData.fromMap(fields);
  }

  /// Creates a MultipartFile from a file path
  static Future<MultipartFile> createMultipartFile(
    String filePath, {
    String? filename,
    DioMediaType? contentType,
  }) {
    return MultipartFile.fromFile(
      filePath,
      filename: filename,
      contentType: contentType,
    );
  }

  /// Closes the client and cancels all pending requests
  void close({bool force = false}) {
    _dio.close(force: force);
  }
}
