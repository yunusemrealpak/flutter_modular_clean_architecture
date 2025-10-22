import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

import '../../../core/errors/failures.dart';
import '../../domain/entities/example_entity.dart';
import '../../domain/repositories/example_repository.dart';
import '../datasources/example_local_datasource.dart';
import '../datasources/example_remote_datasource.dart';

/// Implementation of ExampleRepository
/// Orchestrates data flow between remote and local data sources
@LazySingleton(as: ExampleRepository)
class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleRemoteDataSource remoteDataSource;
  final ExampleLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ExampleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ExampleEntity>> getExampleById({
    required String id,
  }) async {
    // Try to get from local storage first
    try {
      final cachedExample = await localDataSource.getExampleById(id);
      if (cachedExample != null) {
        return Right(cachedExample.toEntity());
      }
    } catch (e) {
      // Continue to fetch from remote
    }

    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        ),
      );
    }

    try {
      final exampleModel = await remoteDataSource.getExampleById(id);

      // Save to local storage for caching
      await localDataSource.saveExample(exampleModel);

      return Right(exampleModel.toEntity());
    } on NotFoundException catch (e) {
      return Left(
        ValidationFailure(
          message: e.message,
          code: 'NOT_FOUND',
        ),
      );
    } on NetworkException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message,
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to get example data',
          code: 'GET_EXAMPLE_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ExampleEntity>>> getAllExamples() async {
    // Try to get from local storage first
    try {
      final cachedExamples = await localDataSource.getAllExamples();
      if (cachedExamples.isNotEmpty) {
        return Right(
          cachedExamples.map((model) => model.toEntity()).toList(),
        );
      }
    } catch (e) {
      // Continue to fetch from remote
    }

    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        ),
      );
    }

    try {
      final exampleModels = await remoteDataSource.getAllExamples();

      // Save to local storage for caching
      for (var model in exampleModels) {
        await localDataSource.saveExample(model);
      }

      return Right(
        exampleModels.map((model) => model.toEntity()).toList(),
      );
    } on NetworkException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message,
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to get all examples',
          code: 'GET_ALL_EXAMPLES_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ExampleEntity>> createExample({
    required String name,
    required String description,
  }) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        ),
      );
    }

    try {
      final exampleModel = await remoteDataSource.createExample(
        name: name,
        description: description,
      );

      // Save to local storage
      await localDataSource.saveExample(exampleModel);

      return Right(exampleModel.toEntity());
    } on NetworkException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message,
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to create example',
          code: 'CREATE_EXAMPLE_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ExampleEntity>> updateExample({
    required String id,
    required String name,
    required String description,
  }) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        ),
      );
    }

    try {
      final exampleModel = await remoteDataSource.updateExample(
        id: id,
        name: name,
        description: description,
      );

      // Update local storage
      await localDataSource.saveExample(exampleModel);

      return Right(exampleModel.toEntity());
    } on NotFoundException catch (e) {
      return Left(
        ValidationFailure(
          message: e.message,
          code: 'NOT_FOUND',
        ),
      );
    } on NetworkException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message,
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to update example',
          code: 'UPDATE_EXAMPLE_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteExample({required String id}) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        ),
      );
    }

    try {
      await remoteDataSource.deleteExample(id);

      // Delete from local storage
      await localDataSource.deleteExample(id);

      return const Right(unit);
    } on NotFoundException catch (e) {
      return Left(
        ValidationFailure(
          message: e.message,
          code: 'NOT_FOUND',
        ),
      );
    } on NetworkException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message,
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to delete example',
          code: 'DELETE_EXAMPLE_FAILED',
        ),
      );
    }
  }
}
