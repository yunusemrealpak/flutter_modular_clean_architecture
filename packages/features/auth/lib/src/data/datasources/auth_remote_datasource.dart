import 'package:config/config.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

import '../models/auth_response_model.dart';
import '../models/auth_token_model.dart';
import '../models/user_model.dart';

/// Authentication remote data source interface
abstract class AuthRemoteDataSource {
  /// Login with email and password
  Future<AuthTokenModel> login({
    required String email,
    required String password,
  });

  /// Register a new user
  Future<AuthTokenModel> register({
    required String email,
    required String password,
    required String name,
  });

  /// Logout the current user
  Future<void> logout();

  /// Get current authenticated user
  Future<UserModel> getCurrentUser();

  /// Refresh authentication token
  Future<AuthTokenModel> refreshToken({required String refreshToken});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClient httpClient;

  AuthRemoteDataSourceImpl(this.httpClient);

  @override
  Future<AuthTokenModel> login({
    required String email,
    required String password,
  }) async {
    httpClient.addHeader('Authorization', 'Bearer fake_access_token');

    return AuthTokenModel(
      AuthTokenModelData(
        accessToken: 'fake_access_token',
        refreshToken: 'fake_refresh_token',
        expiresIn: 3600,
        tokenType: 'Bearer',
        issuedAt: DateTime.now(),
      ),
    );

    try {
      final response = await httpClient.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      return AuthTokenModel(authResponse.token);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(message: 'Failed to parse login response');
    }
  }

  @override
  Future<AuthTokenModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await httpClient.post(
        ApiEndpoints.register,
        data: {'email': email, 'password': password, 'name': name},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      return AuthTokenModel(authResponse.token);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(message: 'Failed to parse register response');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await httpClient.post(ApiEndpoints.logout);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const UnknownException(message: 'Failed to logout');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await httpClient.get(ApiEndpoints.profile);
      return UserModel.fromJson(response.data);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(message: 'Failed to parse user response');
    }
  }

  @override
  Future<AuthTokenModel> refreshToken({required String refreshToken}) async {
    try {
      final response = await httpClient.post(
        ApiEndpoints.refreshToken,
        data: {'refresh_token': refreshToken},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      return AuthTokenModel(authResponse.token);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(
        message: 'Failed to parse refresh token response',
      );
    }
  }
}
