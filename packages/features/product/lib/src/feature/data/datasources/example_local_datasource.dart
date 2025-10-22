import 'package:injectable/injectable.dart';
import 'package:storage/storage.dart';

import '../models/example_model.dart';

/// Local data source interface for example data
/// Handles local storage operations
abstract class ExampleLocalDataSource {
  /// Save example data to local storage
  Future<void> saveExample(ExampleModel example);

  /// Get example data by id from local storage
  Future<ExampleModel?> getExampleById(String id);

  /// Get all example data from local storage
  Future<List<ExampleModel>> getAllExamples();

  /// Delete example data from local storage
  Future<void> deleteExample(String id);

  /// Clear all example data
  Future<void> clearAll();
}

/// Implementation of ExampleLocalDataSource
/// Uses StorageHelper for local persistence
@LazySingleton(as: ExampleLocalDataSource)
class ExampleLocalDataSourceImpl implements ExampleLocalDataSource {
  // TODO: Uncomment when storage DB model is created
  // late final StorageHelper<ExampleDbModel> _storage;
  //
  // ExampleLocalDataSourceImpl(this._storage);

  @override
  Future<void> saveExample(ExampleModel example) async {
    // TODO: Implement storage save
    // final dbModel = ExampleDbModel(
    //   id: example.data.id,
    //   name: example.data.name,
    //   description: example.data.description,
    //   createdAt: example.data.createdAt,
    //   updatedAt: example.data.updatedAt,
    // );
    // await _storage.save(dbModel);
  }

  @override
  Future<ExampleModel?> getExampleById(String id) async {
    // TODO: Implement storage retrieval by id
    // final dbModel = await _storage.findById(id);
    // if (dbModel == null) return null;
    //
    // return ExampleModel(
    //   ExampleModelData(
    //     id: dbModel.id,
    //     name: dbModel.name,
    //     description: dbModel.description,
    //     createdAt: dbModel.createdAt,
    //     updatedAt: dbModel.updatedAt,
    //   ),
    // );
    return null;
  }

  @override
  Future<List<ExampleModel>> getAllExamples() async {
    // TODO: Implement get all from storage
    // final dbModels = await _storage.findAll();
    // return dbModels
    //     .map((dbModel) => ExampleModel(
    //           ExampleModelData(
    //             id: dbModel.id,
    //             name: dbModel.name,
    //             description: dbModel.description,
    //             createdAt: dbModel.createdAt,
    //             updatedAt: dbModel.updatedAt,
    //           ),
    //         ))
    //     .toList();
    return [];
  }

  @override
  Future<void> deleteExample(String id) async {
    // TODO: Implement storage deletion
    // await _storage.deleteById(id);
  }

  @override
  Future<void> clearAll() async {
    // TODO: Implement clear all
    // await _storage.deleteAll();
  }
}
