import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late ConnectivityInterceptor connectivityInterceptor;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/test'));
  });

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    connectivityInterceptor = ConnectivityInterceptor(mockNetworkInfo);
  });

  group('ConnectivityInterceptor Tests', () {
    test('should allow request when connected to internet', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      final options = RequestOptions(path: '/test');
      final handler = _TestRequestHandler();

      // Act
      await connectivityInterceptor.onRequest(options, handler);

      // Assert
      expect(handler.wasNextCalled, true);
      expect(handler.wasRejectCalled, false);
      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    test('should reject request when not connected to internet', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final options = RequestOptions(path: '/test');
      final handler = _TestRequestHandler();

      // Act
      await connectivityInterceptor.onRequest(options, handler);

      // Assert
      expect(handler.wasNextCalled, false);
      expect(handler.wasRejectCalled, true);
      expect(handler.rejectedError?.error, isA<NoInternetException>());
      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    test('should reject with correct error type', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final options = RequestOptions(path: '/test');
      final handler = _TestRequestHandler();

      // Act
      await connectivityInterceptor.onRequest(options, handler);

      // Assert
      expect(handler.rejectedError?.type, DioExceptionType.connectionError);
      expect(handler.rejectedError?.error, isA<NoInternetException>());
    });
  });
}

// Test request handler for testing
class _TestRequestHandler extends RequestInterceptorHandler {
  bool wasNextCalled = false;
  bool wasRejectCalled = false;
  DioException? rejectedError;

  @override
  void next(RequestOptions requestOptions) {
    wasNextCalled = true;
  }

  @override
  void reject(DioException error, [bool newError = false]) {
    wasRejectCalled = true;
    rejectedError = error;
  }
}
