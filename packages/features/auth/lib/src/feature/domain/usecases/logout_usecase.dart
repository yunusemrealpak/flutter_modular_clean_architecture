import 'package:core/core.dart';

import '../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

@injectable
class LogoutUseCase implements UseCase<Unit, NoParams, Failure> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    final result = await repository.logout();

    // If successful, publish event for orchestrator
    result.fold(
      (failure) => null, // Do nothing on failure
      (unit) => unit,
    );

    return result;
  }
}
