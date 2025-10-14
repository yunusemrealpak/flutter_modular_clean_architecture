import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:network/network.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late HttpClient httpClient;
  late NetworkInfo networkInfo;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    networkInfo = NetworkInfoImpl();

    final config = HttpClientConfig(
      baseUrl: 'https://api.example.com',
      enableLogging: false,
      enableRetry: false,
      enableConnectivityCheck: false,
    );

    httpClient = HttpClient(
      config: config,
      networkInfo: networkInfo,
      dio: dio,
    );
  });

  group('HttpClient GET Tests', () {
    test('GET request should return successful response', () async {
      // Arrange
      const path = '/users';
      final responseData = {'id': 1, 'name': 'John Doe'};

      dioAdapter.onGet(
        path,
        (server) => server.reply(200, responseData),
      );

      // Act
      final response = await httpClient.get(path);

      // Assert
      expect(response.statusCode, 200);
      expect(response.data, responseData);
    });

    test('GET request with query parameters should work', () async {
      // Arrange
      const path = '/users';
      final queryParams = {'page': 1, 'limit': 10};
      final responseData = {'items': []};

      dioAdapter.onGet(
        path,
        (server) => server.reply(200, responseData),
        queryParameters: queryParams,
      );

      // Act
      final response = await httpClient.get(
        path,
        queryParameters: queryParams,
      );

      // Assert
      expect(response.statusCode, 200);
      expect(response.data, responseData);
    });
  });

  group('HttpClient POST Tests', () {
    test('POST request should send data correctly', () async {
      // Arrange
      const path = '/users';
      final requestData = {'name': 'John Doe', 'email': 'john@example.com'};
      final responseData = {'id': 1, ...requestData};

      dioAdapter.onPost(
        path,
        (server) => server.reply(201, responseData),
        data: requestData,
      );

      // Act
      final response = await httpClient.post(path, data: requestData);

      // Assert
      expect(response.statusCode, 201);
      expect(response.data, responseData);
    });
  });

  group('HttpClient PUT Tests', () {
    test('PUT request should update data correctly', () async {
      // Arrange
      const path = '/users/1';
      final requestData = {'name': 'Jane Doe'};
      final responseData = {'id': 1, ...requestData};

      dioAdapter.onPut(
        path,
        (server) => server.reply(200, responseData),
        data: requestData,
      );

      // Act
      final response = await httpClient.put(path, data: requestData);

      // Assert
      expect(response.statusCode, 200);
      expect(response.data, responseData);
    });
  });

  group('HttpClient DELETE Tests', () {
    test('DELETE request should work correctly', () async {
      // Arrange
      const path = '/users/1';

      dioAdapter.onDelete(
        path,
        (server) => server.reply(204, null),
      );

      // Act
      final response = await httpClient.delete(path);

      // Assert
      expect(response.statusCode, 204);
    });
  });

  group('HttpClient Configuration Tests', () {
    test('should have correct base URL', () {
      expect(httpClient.config.baseUrl, 'https://api.example.com');
    });

    test('should have correct timeout values', () {
      expect(httpClient.config.connectTimeout, const Duration(seconds: 30));
      expect(httpClient.config.receiveTimeout, const Duration(seconds: 30));
    });

    test('should allow access to underlying Dio instance', () {
      expect(httpClient.dio, isA<Dio>());
    });
  });

  group('HttpClient Auth Interceptor Tests', () {
    test('should add auth interceptor correctly', () {
      // Arrange
      Future<String?> getToken() async => 'test_token';

      // Act
      httpClient.addAuthInterceptor(getAccessToken: getToken);

      // Assert
      final hasAuthInterceptor = httpClient.dio.interceptors
          .any((interceptor) => interceptor is AuthInterceptor);
      expect(hasAuthInterceptor, true);
    });
  });

  group('HttpClient Custom Interceptor Tests', () {
    test('should add custom interceptor correctly', () {
      // Arrange
      final customInterceptor = TestInterceptor();

      // Act
      httpClient.addInterceptor(customInterceptor);

      // Assert
      expect(httpClient.dio.interceptors.contains(customInterceptor), true);
    });
  });
}

// Test interceptor for testing
class TestInterceptor extends Interceptor {}
