import 'package:core/core.dart';

import '../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class GetCurrentUserUseCase implements UseCase<UserEntity, NoParams, Failure> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
