import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';

/// Base use case interface
/// All use cases should implement this interface
abstract class UseCase<Type, Params> {
  /// Execute the use case
  /// Returns [Right(Type)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, Type>> call(Params params);
}

/// No params class for use cases that don't require parameters
class NoParams {
  const NoParams();
}
