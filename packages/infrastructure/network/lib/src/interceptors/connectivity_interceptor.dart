import 'package:dio/dio.dart';
import '../connectivity/network_info.dart';
import '../exceptions/network_exception.dart';

/// Interceptor for checking internet connectivity before making requests
class ConnectivityInterceptor extends Interceptor {
  final NetworkInfo _networkInfo;

  ConnectivityInterceptor(this._networkInfo);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Check if device is connected to the internet
    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      // Reject request if no internet connection
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const NoInternetException(),
          type: DioExceptionType.connectionError,
        ),
      );
    }

    handler.next(options);
  }
}
