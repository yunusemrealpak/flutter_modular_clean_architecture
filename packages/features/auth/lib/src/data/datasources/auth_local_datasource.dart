import 'package:injectable/injectable.dart';

import '../models/auth_token_model.dart';
import '../models/user_model.dart';

/// Authentication local data source interface
/// Handles local storage of auth data
abstract class AuthLocalDataSource {
  /// Save auth token to local storage
  Future<void> saveAuthToken(AuthTokenModel token);

  /// Get auth token from local storage
  Future<AuthTokenModel?> getAuthToken();

  /// Remove auth token from local storage
  Future<void> removeAuthToken();

  /// Save user data to local storage
  Future<void> saveUser(UserModel user);

  /// Get user data from local storage
  Future<UserModel?> getUser();

  /// Remove user data from local storage
  Future<void> removeUser();

  /// Check if user is authenticated (has valid token)
  Future<bool> isAuthenticated();

  /// Clear all auth data
  Future<void> clearAuthData();
}

/// Implementation of [AuthLocalDataSource]
/// This is a placeholder implementation
/// You'll need to implement actual storage logic with shared_preferences or hive
@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // TODO: Add actual storage implementation (shared_preferences, hive, etc.)
  // For now, using in-memory storage as placeholder

  AuthTokenModel? _cachedToken;
  UserModel? _cachedUser;

  @override
  Future<void> saveAuthToken(AuthTokenModel token) async {
    _cachedToken = token;
    // TODO: Implement actual storage
    // Example: await secureStorage.write('auth_token', token.toJson());
  }

  @override
  Future<AuthTokenModel?> getAuthToken() async {
    // TODO: Implement actual storage retrieval
    // Example: final json = await secureStorage.read('auth_token');
    return _cachedToken;
  }

  @override
  Future<void> removeAuthToken() async {
    _cachedToken = null;
    // TODO: Implement actual storage removal
    // Example: await secureStorage.delete('auth_token');
  }

  @override
  Future<void> saveUser(UserModel user) async {
    _cachedUser = user;
    // TODO: Implement actual storage
  }

  @override
  Future<UserModel?> getUser() async {
    // TODO: Implement actual storage retrieval
    return _cachedUser;
  }

  @override
  Future<void> removeUser() async {
    _cachedUser = null;
    // TODO: Implement actual storage removal
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await getAuthToken();
    if (token == null) return false;

    // Check if token is expired
    final entity = token.toEntity();
    return !entity.isExpired;
  }

  @override
  Future<void> clearAuthData() async {
    await removeAuthToken();
    await removeUser();
  }
}
