import 'package:core/core.dart';
import 'package:network/network.dart';

import '../models/example_model.dart';

/// Remote data source interface for example data
/// Handles API calls for example operations
abstract class ExampleRemoteDataSource {
  /// Get example data by id from API
  Future<ExampleModel> getExampleById(String id);

  /// Get all example data from API
  Future<List<ExampleModel>> getAllExamples();

  /// Create new example data on server
  Future<ExampleModel> createExample({
    required String name,
    required String description,
  });

  /// Update existing example data on server
  Future<ExampleModel> updateExample({
    required String id,
    required String name,
    required String description,
  });

  /// Delete example data from server
  Future<void> deleteExample(String id);
}

/// Implementation of ExampleRemoteDataSource
/// Uses HttpClient for API communication
@LazySingleton(as: ExampleRemoteDataSource)
class ExampleRemoteDataSourceImpl implements ExampleRemoteDataSource {
  final HttpClient httpClient;

  ExampleRemoteDataSourceImpl(this.httpClient);

  @override
  Future<ExampleModel> getExampleById(String id) async {
    try {
      // TODO: Replace with actual API endpoint
      final response = await httpClient.get('/examples/$id');
      return ExampleModel.fromJson(response.data);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(message: 'Failed to parse example data');
    }
  }

  @override
  Future<List<ExampleModel>> getAllExamples() async {
    try {
      // TODO: Replace with actual API endpoint
      final response = await httpClient.get('/examples');
      final List<dynamic> data = response.data;
      return data.map((json) => ExampleModel.fromJson(json)).toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(message: 'Failed to parse examples list');
    }
  }

  @override
  Future<ExampleModel> createExample({
    required String name,
    required String description,
  }) async {
    try {
      // TODO: Replace with actual API endpoint
      final response = await httpClient.post(
        '/examples',
        data: {'name': name, 'description': description},
      );
      return ExampleModel.fromJson(response.data);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(message: 'Failed to create example');
    }
  }

  @override
  Future<ExampleModel> updateExample({
    required String id,
    required String name,
    required String description,
  }) async {
    try {
      // TODO: Replace with actual API endpoint
      final response = await httpClient.put(
        '/examples/$id',
        data: {'name': name, 'description': description},
      );
      return ExampleModel.fromJson(response.data);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(message: 'Failed to update example');
    }
  }

  @override
  Future<void> deleteExample(String id) async {
    try {
      // TODO: Replace with actual API endpoint
      await httpClient.delete('/examples/$id');
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const UnknownException(message: 'Failed to delete example');
    }
  }
}
