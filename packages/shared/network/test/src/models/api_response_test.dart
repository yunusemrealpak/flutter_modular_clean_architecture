import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

void main() {
  group('ApiResponse Tests', () {
    test('success factory should create successful response', () {
      final response = ApiResponse<String>.success(
        data: 'test data',
        message: 'Success',
        statusCode: 200,
      );

      expect(response.success, true);
      expect(response.data, 'test data');
      expect(response.message, 'Success');
      expect(response.statusCode, 200);
    });

    test('error factory should create error response', () {
      final response = ApiResponse<String>.error(
        message: 'Error occurred',
        statusCode: 400,
      );

      expect(response.success, false);
      expect(response.data, isNull);
      expect(response.message, 'Error occurred');
      expect(response.statusCode, 400);
    });

    test('fromJson should parse JSON correctly', () {
      final json = {
        'data': {'id': 1, 'name': 'Test'},
        'success': true,
        'message': 'OK',
        'statusCode': 200,
      };

      final response = ApiResponse<Map<String, dynamic>>.fromJson(json);

      expect(response.success, true);
      expect(response.data, {'id': 1, 'name': 'Test'});
      expect(response.message, 'OK');
      expect(response.statusCode, 200);
    });

    test('fromJson with custom fromJsonT should parse data correctly', () {
      final json = {
        'data': {'id': 1, 'name': 'Test'},
        'success': true,
      };

      final response = ApiResponse<TestModel>.fromJson(
        json,
        fromJsonT: (data) => TestModel.fromJson(data),
      );

      expect(response.success, true);
      expect(response.data?.id, 1);
      expect(response.data?.name, 'Test');
    });

    test('toJson should convert to JSON correctly', () {
      final response = ApiResponse<String>.success(
        data: 'test',
        message: 'OK',
        statusCode: 200,
      );

      final json = response.toJson();

      expect(json['data'], 'test');
      expect(json['success'], true);
      expect(json['message'], 'OK');
      expect(json['statusCode'], 200);
    });

    test('copyWith should create a copy with modified fields', () {
      final response = ApiResponse<String>.success(
        data: 'original',
        message: 'Original message',
      );

      final copied = response.copyWith(
        data: 'modified',
        statusCode: 201,
      );

      expect(copied.data, 'modified');
      expect(copied.message, 'Original message');
      expect(copied.statusCode, 201);
      expect(copied.success, true);
    });
  });
}

// Test model for testing
class TestModel {
  final int id;
  final String name;

  TestModel({required this.id, required this.name});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
