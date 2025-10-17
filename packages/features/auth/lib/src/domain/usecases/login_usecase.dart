import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/failures.dart';
import '../entities/auth_token_entity.dart';
import '../repositories/auth_repository.dart';
import 'base_usecase.dart';

@injectable
class LoginUseCase implements UseCase<AuthTokenEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthTokenEntity>> call(LoginParams params) async {
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

    // Call repository to perform login
    final result = await repository.login(
      email: params.email,
      password: params.password,
    );

    // If successful, publish event for orchestrator
    result.fold(
      (failure) => null, // Do nothing on failure
      (token) {
        // Feature says: "authentication successful"
        // Orchestrator decides where to navigate
        EventBus.I.publish(
          const AuthenticationSuccessEvent(
            isFirstLogin: false, // TODO: Determine from token or user data
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

/// Login parameters
class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
