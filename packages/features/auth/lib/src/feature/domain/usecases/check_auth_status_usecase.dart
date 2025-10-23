import 'package:auth/auth.dart';
import 'package:core/core.dart';

@injectable
class CheckAuthStatusUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isAuthenticated();
  }
}
