import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

void main() {
  group('NetworkException Tests', () {
    test('NoInternetException should have correct message and code', () {
      const exception = NoInternetException();

      expect(exception.message, 'No internet connection available');
      expect(exception.code, 'NO_INTERNET');
      expect(exception.statusCode, isNull);
    });

    test('TimeoutException should have correct message and code', () {
      const exception = TimeoutException();

      expect(exception.message, 'Request timeout');
      expect(exception.code, 'TIMEOUT');
      expect(exception.statusCode, isNull);
    });

    test('BadRequestException should have correct status code', () {
      const exception = BadRequestException();

      expect(exception.message, 'Bad request');
      expect(exception.code, 'BAD_REQUEST');
      expect(exception.statusCode, 400);
    });

    test('UnauthorizedException should have correct status code', () {
      const exception = UnauthorizedException();

      expect(exception.message, 'Unauthorized');
      expect(exception.code, 'UNAUTHORIZED');
      expect(exception.statusCode, 401);
    });

    test('NotFoundException should have correct status code', () {
      const exception = NotFoundException();

      expect(exception.message, 'Resource not found');
      expect(exception.code, 'NOT_FOUND');
      expect(exception.statusCode, 404);
    });

    test('InternalServerException should have correct status code', () {
      const exception = InternalServerException();

      expect(exception.message, 'Internal server error');
      expect(exception.code, 'INTERNAL_SERVER_ERROR');
      expect(exception.statusCode, 500);
    });

    test('Custom message should be used when provided', () {
      const customMessage = 'Custom error message';
      const exception = BadRequestException(message: customMessage);

      expect(exception.message, customMessage);
      expect(exception.statusCode, 400);
    });

    test('CancelException should have correct message', () {
      const exception = CancelException();

      expect(exception.message, 'Request was cancelled');
      expect(exception.code, 'CANCELLED');
    });

    test('ParseException should have correct message', () {
      const exception = ParseException();

      expect(exception.message, 'Failed to parse response');
      expect(exception.code, 'PARSE_ERROR');
    });
  });
}
