import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

void main() {
  group('PaginatedResponse Tests', () {
    test('fromJson should parse JSON correctly', () {
      final json = {
        'items': [
          {'id': 1, 'name': 'Item 1'},
          {'id': 2, 'name': 'Item 2'},
        ],
        'currentPage': 1,
        'totalPages': 5,
        'totalItems': 50,
        'pageSize': 10,
      };

      final response = PaginatedResponse<TestItem>.fromJson(
        json,
        (json) => TestItem.fromJson(json),
      );

      expect(response.items.length, 2);
      expect(response.items[0].id, 1);
      expect(response.items[0].name, 'Item 1');
      expect(response.currentPage, 1);
      expect(response.totalPages, 5);
      expect(response.totalItems, 50);
      expect(response.pageSize, 10);
      expect(response.hasNextPage, true);
      expect(response.hasPreviousPage, false);
    });

    test('fromJson should handle alternative field names', () {
      final json = {
        'items': [
          {'id': 1, 'name': 'Item 1'},
        ],
        'page': 2,
        'pages': 3,
        'total': 30,
        'limit': 10,
      };

      final response = PaginatedResponse<TestItem>.fromJson(
        json,
        (json) => TestItem.fromJson(json),
      );

      expect(response.currentPage, 2);
      expect(response.totalPages, 3);
      expect(response.totalItems, 30);
      expect(response.pageSize, 10);
    });

    test('hasNextPage should be true when not on last page', () {
      final json = {
        'items': [],
        'currentPage': 2,
        'totalPages': 5,
        'totalItems': 50,
        'pageSize': 10,
      };

      final response = PaginatedResponse<TestItem>.fromJson(
        json,
        (json) => TestItem.fromJson(json),
      );

      expect(response.hasNextPage, true);
    });

    test('hasNextPage should be false when on last page', () {
      final json = {
        'items': [],
        'currentPage': 5,
        'totalPages': 5,
        'totalItems': 50,
        'pageSize': 10,
      };

      final response = PaginatedResponse<TestItem>.fromJson(
        json,
        (json) => TestItem.fromJson(json),
      );

      expect(response.hasNextPage, false);
    });

    test('hasPreviousPage should be true when not on first page', () {
      final json = {
        'items': [],
        'currentPage': 2,
        'totalPages': 5,
        'totalItems': 50,
        'pageSize': 10,
      };

      final response = PaginatedResponse<TestItem>.fromJson(
        json,
        (json) => TestItem.fromJson(json),
      );

      expect(response.hasPreviousPage, true);
    });

    test('hasPreviousPage should be false when on first page', () {
      final json = {
        'items': [],
        'currentPage': 1,
        'totalPages': 5,
        'totalItems': 50,
        'pageSize': 10,
      };

      final response = PaginatedResponse<TestItem>.fromJson(
        json,
        (json) => TestItem.fromJson(json),
      );

      expect(response.hasPreviousPage, false);
    });

    test('toJson should convert to JSON correctly', () {
      final response = PaginatedResponse<TestItem>(
        items: [
          TestItem(id: 1, name: 'Item 1'),
          TestItem(id: 2, name: 'Item 2'),
        ],
        currentPage: 1,
        totalPages: 5,
        totalItems: 50,
        pageSize: 10,
        hasNextPage: true,
        hasPreviousPage: false,
      );

      final json = response.toJson((item) => item.toJson());

      expect(json['items'].length, 2);
      expect(json['currentPage'], 1);
      expect(json['totalPages'], 5);
      expect(json['totalItems'], 50);
      expect(json['pageSize'], 10);
      expect(json['hasNextPage'], true);
      expect(json['hasPreviousPage'], false);
    });

    test('copyWith should create a copy with modified fields', () {
      final response = PaginatedResponse<TestItem>(
        items: [TestItem(id: 1, name: 'Item 1')],
        currentPage: 1,
        totalPages: 5,
        totalItems: 50,
        pageSize: 10,
        hasNextPage: true,
        hasPreviousPage: false,
      );

      final copied = response.copyWith(
        currentPage: 2,
        hasPreviousPage: true,
      );

      expect(copied.currentPage, 2);
      expect(copied.hasPreviousPage, true);
      expect(copied.items.length, 1);
      expect(copied.totalPages, 5);
    });
  });
}

// Test model for testing
class TestItem {
  final int id;
  final String name;

  TestItem({required this.id, required this.name});

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(
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
