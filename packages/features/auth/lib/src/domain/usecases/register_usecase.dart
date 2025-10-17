import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/failures.dart';
import '../entities/auth_token_entity.dart';
import '../repositories/auth_repository.dart';
import 'base_usecase.dart';

@injectable
class RegisterUseCase implements UseCase<AuthTokenEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthTokenEntity>> call(RegisterParams params) async {
    // Validate email
    if (!_isEmailValid(params.email)) {
      return const Left(
        ValidationFailure(
          message: 'Invalid email format',
          code: 'INVALID_EMAIL',
        ),
      );
    }

    // Validate password
    if (!_isPasswordValid(params.password)) {
      return const Left(
        ValidationFailure(
          message: 'Password must be at least 8 characters',
          code: 'INVALID_PASSWORD',
        ),
      );
    }

    // Validate name
    if (params.name.trim().isEmpty) {
      return const Left(
        ValidationFailure(
          message: 'Name cannot be empty',
          code: 'INVALID_NAME',
        ),
      );
    }

    // Call repository to perform registration
    final result = await repository.register(
      email: params.email,
      password: params.password,
      name: params.name,
    );

    // If successful, publish event for orchestrator
    result.fold(
      (failure) => null, // Do nothing on failure
      (token) {
        // Feature says: "registration successful"
        // Orchestrator decides where to navigate (email verification, home, etc.)
        EventBus.I.publish(
          RegistrationSuccessEvent(
            userId: token.accessToken,
            email: params.email,
            requiresEmailVerification: false, // TODO: Determine from response
          ),
        );
      },
    );

    return result;
  }

  /// Validate email format
  bool _isEmailValid(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate password
  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }
}

/// Register parameters
class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String name;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}
