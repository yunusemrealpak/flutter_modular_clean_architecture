import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/example_entity.dart';

/// Example repository interface
/// Defines the contract for data operations
abstract class ExampleRepository {
  /// Get example data by id
  /// Returns [Right(ExampleEntity)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, ExampleEntity>> getExampleById({
    required String id,
  });

  /// Get all example data
  /// Returns [Right(List<ExampleEntity>)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, List<ExampleEntity>>> getAllExamples();

  /// Create new example data
  /// Returns [Right(ExampleEntity)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, ExampleEntity>> createExample({
    required String name,
    required String description,
  });

  /// Update example data
  /// Returns [Right(ExampleEntity)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, ExampleEntity>> updateExample({
    required String id,
    required String name,
    required String description,
  });

  /// Delete example data
  /// Returns [Right(Unit)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, Unit>> deleteExample({required String id});
}
