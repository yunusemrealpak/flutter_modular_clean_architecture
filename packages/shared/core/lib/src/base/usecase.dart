import 'package:dartz/dartz.dart';

/// Base interface for all use cases
/// Type: Return type
/// Params: Parameters required by the use case
abstract class UseCase<T, Params, Failure> {
  /// Execute the use case
  Future<Either<Failure, T>> call(Params params);
}

/// No parameters class for use cases that don't require parameters
class NoParams {
  const NoParams();
}
