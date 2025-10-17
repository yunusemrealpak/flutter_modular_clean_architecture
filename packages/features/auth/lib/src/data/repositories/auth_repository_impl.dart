import 'package:dartz/dartz.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/auth_token_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthTokenEntity>> login({
    required String email,
    required String password,
  }) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(message: 'No internet connection', code: 'NO_INTERNET'),
      );
    }

    try {
      final tokenModel = await remoteDataSource.login(
        email: email,
        password: password,
      );

      // Save token to local storage
      await localDataSource.saveAuthToken(tokenModel);

      return Right(tokenModel.toEntity());
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message, code: 'INVALID_CREDENTIALS'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to login', code: 'LOGIN_FAILED'),
      );
    }
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(message: 'No internet connection', code: 'NO_INTERNET'),
      );
    }

    try {
      final tokenModel = await remoteDataSource.register(
        email: email,
        password: password,
        name: name,
      );

      // Save token to local storage
      await localDataSource.saveAuthToken(tokenModel);

      return Right(tokenModel.toEntity());
    } on ConflictException catch (e) {
      return Left(AuthFailure(message: e.message, code: 'EMAIL_EXISTS'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to register',
          code: 'REGISTRATION_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      // Try to logout from server if connected
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        try {
          await remoteDataSource.logout();
        } catch (e) {
          // Continue even if server logout fails
        }
      }

      // Clear local auth data
      await localDataSource.clearAuthData();

      return const Right(unit);
    } catch (e) {
      return Left(
        CacheFailure(
          message: 'Failed to clear local auth data',
          code: 'LOGOUT_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    // Try to get user from local storage first
    try {
      final cachedUser = await localDataSource.getUser();
      if (cachedUser != null) {
        return Right(cachedUser.toEntity());
      }
    } catch (e) {
      // Continue to fetch from remote
    }

    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(message: 'No internet connection', code: 'NO_INTERNET'),
      );
    }

    try {
      final userModel = await remoteDataSource.getCurrentUser();

      // Save user to local storage
      await localDataSource.saveUser(userModel);

      return Right(userModel.toEntity());
    } on UnauthorizedException catch (e) {
      // Session expired or invalid token
      // Feature says: "unauthorized access detected"
      // Orchestrator decides what to do (clear data, show dialog, navigate to login)
      EventBus.I.publish(UnauthorizedAccessEvent(message: e.message));
      return const Left(UnauthorizedFailure());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to get current user',
          code: 'GET_USER_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> refreshToken({
    required String refreshToken,
  }) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(message: 'No internet connection', code: 'NO_INTERNET'),
      );
    }

    try {
      final tokenModel = await remoteDataSource.refreshToken(
        refreshToken: refreshToken,
      );

      // Save new token to local storage
      await localDataSource.saveAuthToken(tokenModel);

      return Right(tokenModel.toEntity());
    } on UnauthorizedException catch (e) {
      // Clear local data if refresh token is invalid
      await localDataSource.clearAuthData();

      // Session expired - refresh token is invalid
      // Feature says: "session expired"
      // Orchestrator decides what to do (show dialog, navigate to login)
      EventBus.I.publish(SessionExpiredEvent());

      return const Left(
        UnauthorizedFailure(
          message: 'Refresh token expired',
          code: 'REFRESH_TOKEN_EXPIRED',
        ),
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to refresh token',
          code: 'REFRESH_TOKEN_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final isAuth = await localDataSource.isAuthenticated();
      return Right(isAuth);
    } catch (e) {
      return Left(
        CacheFailure(
          message: 'Failed to check authentication status',
          code: 'CHECK_AUTH_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword({required String email}) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(message: 'No internet connection', code: 'NO_INTERNET'),
      );
    }

    try {
      // TODO: Implement forgot password remote call
      // await remoteDataSource.forgotPassword(email: email);
      return const Right(unit);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to send password reset email',
          code: 'FORGOT_PASSWORD_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(message: 'No internet connection', code: 'NO_INTERNET'),
      );
    }

    try {
      // TODO: Implement reset password remote call
      // await remoteDataSource.resetPassword(token: token, newPassword: newPassword);
      return const Right(unit);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to reset password',
          code: 'RESET_PASSWORD_FAILED',
        ),
      );
    }
  }
}
