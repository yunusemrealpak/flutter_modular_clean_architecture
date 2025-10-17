import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/auth_token_entity.dart';
import '../entities/user_entity.dart';

/// Authentication repository interface
/// Defines the contract for authentication operations
abstract class AuthRepository {
  /// Login with email and password
  /// Returns [Right(AuthTokenEntity)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, AuthTokenEntity>> login({
    required String email,
    required String password,
  });

  /// Register a new user
  /// Returns [Right(AuthTokenEntity)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, AuthTokenEntity>> register({
    required String email,
    required String password,
    required String name,
  });

  /// Logout the current user
  /// Returns [Right(Unit)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, Unit>> logout();

  /// Get current authenticated user
  /// Returns [Right(UserEntity)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Refresh authentication token
  /// Returns [Right(AuthTokenEntity)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, AuthTokenEntity>> refreshToken({
    required String refreshToken,
  });

  /// Check if user is authenticated
  /// Returns [Right(bool)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, bool>> isAuthenticated();

  /// Forgot password - send reset email
  /// Returns [Right(Unit)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, Unit>> forgotPassword({
    required String email,
  });

  /// Reset password with token
  /// Returns [Right(Unit)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, Unit>> resetPassword({
    required String token,
    required String newPassword,
  });
}
