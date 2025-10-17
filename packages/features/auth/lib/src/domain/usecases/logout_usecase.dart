import 'package:dartz/dartz.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';
import 'base_usecase.dart';

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
      (unit) {
        // Feature says: "logout successful"
        // Orchestrator decides where to navigate (clear data, go to login, etc.)
        EventBus.I.publish(const LogoutSuccessEvent(reason: 'user_initiated'));
      },
    );

    return result;
  }
}
