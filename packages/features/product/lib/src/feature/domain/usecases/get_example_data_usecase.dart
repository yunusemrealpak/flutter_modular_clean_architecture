import 'package:core/core.dart';

import '../../../core/errors/failures.dart';
import '../entities/example_entity.dart';
import '../repositories/example_repository.dart';

/// Use case for getting example data
/// Demonstrates the use case pattern with validation and business logic
@injectable
class GetExampleDataUseCase
    implements UseCase<ExampleEntity, GetExampleDataParams, Failure> {
  final ExampleRepository repository;

  GetExampleDataUseCase(this.repository);

  @override
  Future<Either<Failure, ExampleEntity>> call(
      GetExampleDataParams params) async {
    // Validate input
    if (params.id.isEmpty) {
      return const Left(
        ValidationFailure(
          message: 'ID cannot be empty',
          code: 'INVALID_ID',
        ),
      );
    }

    // Call repository to fetch data
    final result = await repository.getExampleById(id: params.id);

    // Apply business logic if needed
    return result.fold(
      (failure) => Left(failure),
      (entity) {
        // Example: Check if data is recent
        if (entity.isRecent) {
          // Could publish an event here if needed
          // EventBus.instance.publish(RecentDataFoundEvent(entity));
        }
        return Right(entity);
      },
    );
  }
}

/// Parameters for GetExampleDataUseCase
class GetExampleDataParams extends Equatable {
  final String id;

  const GetExampleDataParams({required this.id});

  @override
  List<Object?> get props => [id];
}
