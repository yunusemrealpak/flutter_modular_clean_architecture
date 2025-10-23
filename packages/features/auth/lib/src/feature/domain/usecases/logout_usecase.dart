import 'package:core/core.dart';

import '../repositories/auth_repository.dart';

@injectable
class LogoutUseCase implements UseCase<Unit, NoParams> {
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
