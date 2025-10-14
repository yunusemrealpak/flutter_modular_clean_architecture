import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

void main() {
  late ErrorInterceptor errorInterceptor;

  setUp(() {
    errorInterceptor = ErrorInterceptor();
  });

  group('ErrorInterceptor Tests', () {
    test('should convert timeout exception to TimeoutException', () {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      NetworkException? capturedError;
      final handler = _TestErrorHandler((error) {
        capturedError = error.error as NetworkException?;
      });

      // Act
      errorInterceptor.onError(dioError, handler);

      // Assert
      expect(capturedError, isA<TimeoutException>());
    });

    test('should convert 401 to UnauthorizedException', () {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
        ),
      );

      NetworkException? capturedError;
      final handler = _TestErrorHandler((error) {
        capturedError = error.error as NetworkException?;
      });

      // Act
      errorInterceptor.onError(dioError, handler);

      // Assert
      expect(capturedError, isA<UnauthorizedException>());
    });

    test('should convert 404 to NotFoundException', () {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 404,
        ),
      );

      NetworkException? capturedError;
      final handler = _TestErrorHandler((error) {
        capturedError = error.error as NetworkException?;
      });

      // Act
      errorInterceptor.onError(dioError, handler);

      // Assert
      expect(capturedError, isA<NotFoundException>());
    });

    test('should convert 500 to InternalServerException', () {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
        ),
      );

      NetworkException? capturedError;
      final handler = _TestErrorHandler((error) {
        capturedError = error.error as NetworkException?;
      });

      // Act
      errorInterceptor.onError(dioError, handler);

      // Assert
      expect(capturedError, isA<InternalServerException>());
    });

    test('should convert cancel exception to CancelException', () {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.cancel,
      );

      NetworkException? capturedError;
      final handler = _TestErrorHandler((error) {
        capturedError = error.error as NetworkException?;
      });

      // Act
      errorInterceptor.onError(dioError, handler);

      // Assert
      expect(capturedError, isA<CancelException>());
    });

    test('should convert connection error to NoInternetException', () {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
      );

      NetworkException? capturedError;
      final handler = _TestErrorHandler((error) {
        capturedError = error.error as NetworkException?;
      });

      // Act
      errorInterceptor.onError(dioError, handler);

      // Assert
      expect(capturedError, isA<NoInternetException>());
    });

    test('should call onErrorCallback when provided', () {
      // Arrange
      NetworkException? callbackError;
      final errorInterceptorWithCallback = ErrorInterceptor(
        onErrorCallback: (error) => callbackError = error,
      );

      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      final handler = _TestErrorHandler((_) {});

      // Act
      errorInterceptorWithCallback.onError(dioError, handler);

      // Assert
      expect(callbackError, isA<TimeoutException>());
    });

    test('should extract error message from response data', () {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 400,
          data: {'message': 'Custom error message'},
        ),
      );

      NetworkException? capturedError;
      final handler = _TestErrorHandler((error) {
        capturedError = error.error as NetworkException?;
      });

      // Act
      errorInterceptor.onError(dioError, handler);

      // Assert
      expect(capturedError, isA<BadRequestException>());
      expect(capturedError?.message, 'Custom error message');
    });
  });
}

// Test error handler for testing
class _TestErrorHandler extends ErrorInterceptorHandler {
  final void Function(DioException) onNextCalled;

  _TestErrorHandler(this.onNextCalled);

  @override
  void next(DioException err) {
    onNextCalled(err);
  }
}
